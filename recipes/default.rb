include_recipe 'skellington'

include_recipe 'odi-cert-deployer'

deploy_revision "/home/#{node['user']}/#{node['fully_qualified_domain_name']}" do
  repo "git://github.com/#{node['repo']}"
  user node['user']
  group node['user']
  revision node['deployment']['revision']
  action :force_deploy

  before_migrate do
    current_release_directory = release_path

    bash 'Symlink env' do
      cwd release_path
      user node['user']
      code <<-EOF
        ln -sf /home/#{node['user']}/env .env
      EOF
    end

    directory "/home/#{node['user']}/#{node['fully_qualified_domain_name']}/shared/config/" do
      action :create
      recursive true
    end

    directory "/home/#{node['user']}/#{node['fully_qualified_domain_name']}/shared/log/" do
      action :create
      recursive true
      user node['user']
    end

    bundlify node['user'] do
      cwd current_release_directory
    end
  end

  before_restart do
    current_release_directory = release_path
    port = node['start_port']
    concurrency = node['concurrency']

    foremanise node['user'] do
      cwd current_release_directory
      port port
      concurrency concurrency
    end

    make_vhosts do
      cwd current_release_directory
      user node['user']
      fqdn node['fully_qualified_domain_name']
    end
  end

  restart_command "sudo service #{node['user']} restart"
  notifies :restart, "service[nginx]"
end
