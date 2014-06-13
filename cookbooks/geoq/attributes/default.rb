default['geoq']['debug'] = true
default['geoq']['logging']['location'] = '/var/log/geoq'
default['geoq']['virtualenv']['location'] = '/var/lib/geoq'
default['geoq']['location'] = '/usr/src/geoq'
default['geoq']['git_repo']['location'] = 'https://github.com/ngageoint/geoq.git'
default['geoq']['git_repo']['branch'] = 'master'
default['postgresql']['password']['postgres'] = 'geoq'

default['postgresql']['version'] = '9.3'
default['postgresql']['dir']                             = "/etc/postgresql/9.3/main"
default["postgresql"]["cfg_update_action"]               = :restart
default["postgresql"]["hba_file"]                        = "/etc/postgresql/9.3/main/pg_hba.conf"


default['geoq']['database']['address'] = '127.0.0.1'
default['geoq']['database']['hostname'] = 'geoq-database'
default['geoq']['database']['name'] = 'geoq'
default['geoq']['database']['user'] = 'geoq'
default['geoq']['database']['password'] = 'geoq'
default['geoq']['database']['port'] = '5432'

default[:postgis][:version] = '2.1.3'
default['postgis']['template_name'] = 'template_postgis'
default['postgis']['locale'] = 'en_US.utf8'

default['geoq']['settings']['static_root'] = '/usr/src/static'
default['geoq']['settings']['static_url'] = '/static/'

default['geoq']['settings']['DATABASES'] = {
    :default=>{
        :name => node['geoq']['database']['name'],
        :user => node['geoq']['database']['user'],
        :password => node['geoq']['database']['password'],
        :host => node['geoq']['database']['hostname'],
        :port => node['geoq']['database']['port']
        },
    }

