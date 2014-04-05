geoq_pkgs = "build-essential python-dev libpq-dev libpng-dev libfreetype6 libfreetype6-dev".split

geoq_pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

python_virtualenv node['geoq']['virtualenv']['location'] do
  interpreter "python2.7"
  action :create
end

python_pip "uwsgi" do
  virtualenv node['geoq']['virtualenv']['location']
end

git node['geoq']['location'] do
  repository node['geoq']['git_repo']['location']
  revision node['geoq']['git_repo']['branch']
  action :sync
  notifies :run, "execute[install_geoq_dependencies]", :immediately
  notifies :run, "bash[sync_db]"
  notifies :run, "execute[install_dev_fixtures]"
end

execute "install_geoq_dependencies" do
  command "#{node['geoq']['virtualenv']['location']}/bin/pip install -r geoq/requirements.txt"
  cwd node['geoq']['location']
  action :nothing
  user 'root'
end

execute "install_dev_fixtures" do
  command "sudo #{node['geoq']['virtualenv']['location']}/bin/activate && sudo paver delayed_fixtures"
  cwd node['geoq']['location']
  action :nothing
  user 'root'
end

template "geoq_local_settings" do
  source "local_settings.py.erb"
  path "#{node['geoq']['virtualenv']['location']}/local_settings.py"
  variables ({:database => node['geoq']['settings']['DATABASES']['default']})
end

link "local_settings_symlink" do
  link_type :symbolic
  to "#{node['geoq']['virtualenv']['location']}/local_settings.py"
  target_file "#{node['geoq']['location']}/geoq/local_settings.py"
  not_if do File.exists?("#{node['geoq']['location']}/geoq/local_settings.py") end
end

hostsfile_entry node['geoq']['database']['address'] do
  hostname node['geoq']['database']['hostname']
  only_if do node['geoq']['database']['hostname'] && node['geoq']['database']['address'] end
  action :append
end

include_recipe 'geoq::postgis'
include_recipe 'geoq::database'

directory node['geoq']['logging']['location'] do
  action :create
end

directory node['geoq']['settings']['static_root'] do
  owner "www-data"
  mode 00755
  action :create
  recursive true
end

directory "#{node['geoq']['settings']['static_root']}/CACHE" do
  owner "www-data"
  mode 00755
  action :create
  recursive true
end

directory "#{node['geoq']['settings']['static_root']}/CACHE/js" do
  owner "www-data"
  mode 00755
  action :create
  recursive true
end

directory "#{node['geoq']['settings']['static_root']}/CACHE/css" do
  owner "www-data"
  mode 00755
  action :create
  recursive true
end

bash "sync_db" do
  code "source #{node['geoq']['virtualenv']['location']}/bin/activate && paver sync"
  cwd "#{node['geoq']['location']}"
  action :nothing
end

execute "collect_static" do
  command "#{node['geoq']['virtualenv']['location']}/bin/python manage.py collectstatic --noinput"
  cwd "#{node['geoq']['location']}"
  action :nothing
end

bash "install_fixtures" do
  code "source #{node['geoq']['virtualenv']['location']}/bin/activate && paver delayed_fixtures"
  cwd "#{node['geoq']['location']}"
  user 'postgres'
  action :nothing
end

template "geoq_uwsgi_ini" do
  path "#{node['geoq']['virtualenv']['location']}/geoq.ini"
  source "geoq.ini.erb"
  action :create_if_missing
  notifies :run, "execute[start_django_server]"
end

include_recipe 'geoq::nginx'

start_geoq = "#{node['geoq']['virtualenv']['location']}/bin/uwsgi --ini #{node['geoq']['virtualenv']['location']}/geoq.ini &"

execute "start_django_server" do
  command start_geoq
end

file "/etc/cron.d/geoq_restart" do
  content "@reboot root #{node['geoq']['virtualenv']['location']}/bin/uwsgi --ini #{node['geoq']['virtualenv']['location']}/geoq.ini &"
  mode 00755
  action :create_if_missing
end
