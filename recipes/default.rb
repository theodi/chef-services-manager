user = node['user']
group = node['user']
fqdn = node['fully_qualified_domain_name']

include_recipe 'odi-users'
include_recipe 'apt'
include_recipe 'git'
include_recipe 'odi-pk'
include_recipe 'envbuilder'

include_recipe 'ruby-ng'
include_recipe 'ruby-ng::dev' unless node['ruby-ng']['dev_package']

include_recipe 'chef-client::config'
include_recipe 'chef-client::cron'

include_recipe 'odi-monitoring'

deploy_revision "/home/#{user}/#{fqdn}" do
  repo "git://github.com/#{node['repo']}"
  user user
  group group
  revision node['deployment']['revision']
  action :deploy
end
