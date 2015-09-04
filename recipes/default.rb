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

%w{
  build-essential
  libcurl4-openssl-dev
  libxslt1-dev
}.each do |pkg|
  package pkg do
    action :install
  end
end

if node['ruby-ng']['dev_package']
  package "ruby#{node['dev_package']}-dev" do
    action :install
  end
end

include_recipe 'chef-client::config'
include_recipe 'chef-client::cron'

include_recipe 'odi-monitoring'

deploy_revision "/home/#{user}/#{fqdn}" do
  repo "git://github.com/#{node['repo']}"
  user user
  group group
  revision node['deployment']['revision']
  action :force_deploy

  before_migrate do
    current_release_directory = release_path

    bash 'Symlink env' do
      cwd release_path
      user user
      code <<-EOF
        ln -sf /home/#{user}/env .env
      EOF
    end

    directory "/home/#{user}/#{fqdn}/shared/config/" do
      action :create
      recursive true
    end

    directory "/home/#{user}/#{fqdn}/shared/log/" do
      action :create
      recursive true
      user user
    end


    bundlify user do
      cwd current_release_directory
    end
  end

  before_restart do
    current_release_directory = release_path
    port = node['start_port']
    concurrency = node['concurrency']

    foremanise user do
      cwd current_release_directory
      port port
      concurrency concurrency
    end
  end
end
