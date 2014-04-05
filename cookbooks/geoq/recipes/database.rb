gem_package "pg" do
  action :install
end

postgresql_connection_info = {
  :host     => node['geoq']['database']['hostname'],
  :port     => node['geoq']['database']['port'],
  :username => 'postgres',
  :password => node['postgresql']['password']['postgres']
}

geoq_db = node['geoq']['settings']['DATABASES']['default']

# Create the geoq user
postgresql_database_user geoq_db[:user] do
    connection postgresql_connection_info
    password geoq_db[:password]
    action :create
end

# Create the geoq database
postgresql_database geoq_db[:name] do
  connection postgresql_connection_info
  template node['postgis']['template_name']
  owner geoq_db[:user]
  action :create
  notifies :run, "bash[install_fixtures]"
end

postgresql_database 'set user' do
  connection   postgresql_connection_info
  database_name geoq_db[:name]
  sql 'grant select on geometry_columns, spatial_ref_sys to ' + geoq_db[:user] + ';'
  action :query
end
