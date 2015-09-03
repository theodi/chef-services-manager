include_recipe 'odi-users'
include_recipe 'apt'
include_recipe 'git'
include_recipe 'odi-pk'

include_recipe 'ruby-ng'
include_recipe 'ruby-ng::dev' unless node['ruby-ng']['dev_package']

include_recipe 'chef-client::config'
include_recipe 'chef-client::cron'
