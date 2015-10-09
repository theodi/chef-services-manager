default['user'] = 'services-manager'
default['fully_qualified_domain_name'] = "#{node['user']}.theodi.org"
default['start_port'] = 3000
default['repo'] = "theodi/#{node['user']}"
default['concurrency'] = 1
default['concurrency_string'] = "worker=4,scheduler=1,web=#{node['concurrency']}"

default['ruby-ng']['ruby_version'] = '1.9.3'

default['cert']['name'] = 'xero'
default['cert']['file'] = 'privatekey.pem'
