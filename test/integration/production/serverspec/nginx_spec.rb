require 'serverspec'
set :backend, :exec

describe package 'nginx' do
  it { should be_installed }
end

describe service 'nginx' do
  it { should be_running }
end

describe file '/etc/nginx/sites-enabled/services-manager.theodi.org' do
  it { should be_symlink }
  its(:content) { should match /server 127.0.0.1:3000;/ }
  its(:content) { should match /listen 80 default;/ }
  its(:content) { should match /server_name services-manager.theodi.org;/ }
  its(:content) { should match /proxy_pass http:\/\/services-manager;/ }
end

describe file '/etc/nginx/sites-enabled/default' do
  it { should_not exist }
end
