deploy_revision "/home/#{node['user']}/#{node['fully_qualified_domain_name']}" do
  repo "git://github.com/#{node['repo']}"
  user node['user']
  group node['user']
  revision node['deployment']['revision']
  action :force_deploy

  before_migrate do
    current_release_directory = release_path

    pre_bundle node['user'] do
      release_path current_release_directory
      fully_qualified_domain_name node['fully_qualified_domain_name']
    end

    bundlify node['user'] do
      cwd current_release_directory
    end
  end

  before_restart do
    current_release_directory = release_path

    foremanise node['user'] do
      cwd current_release_directory
      port node['start_port']
      concurrency_string node['concurrency_string']
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
