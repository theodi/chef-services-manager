default['user'] = 'services-manager'
default['fully_qualified_domain_name'] = 'services-manager.theodi.org'
default['repo'] = 'theodi/services-manager'
default['concurrency'] = 1

default['ruby-ng']['ruby_version'] = '1.9.3'
default['ruby-ng']['dev_package'] = '1.9.1'

default['chef_client']['init_style'] = 'none'
default['chef_client']['cron']['use_cron_d'] = true
default['chef_client']['cron']['hour'] = '*'
default['chef_client']['cron']['minute'] = '*/10'

default['envbuilder']['base_dir'] = '/home/services-manager'
default['envbuilder']['owner'] = 'services-manager'
default['envbuilder']['group'] = 'services-manager'

default['deployment']['revision'] = 'CURRENT'
