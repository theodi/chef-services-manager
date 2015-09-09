require 'serverspec'
set :backend, :exec

describe file '/var/log/services-manager' do
  it { should be_directory }
end

describe file '/var/run/services-manager' do
  it { should be_directory }
end

describe file '/etc/init/services-manager.conf' do
  it { should be_file }
  its(:content) { should match /start on runlevel \[2345\]/ }
end

describe file '/etc/init/services-manager-web-1.conf' do
  it { should be_file }
  its(:content) { should match /start on starting services-manager-web/ }
  its(:content) { should match /exec su - services-manager -c 'cd \/home\/services-manager\/services-manager.theodi.org\// }
end

describe file '/etc/init/services-manager-scheduler-1.conf' do
  it { should be_file }
  its(:content) { should match /start on starting services-manager-scheduler/ }
end

describe file '/etc/init/services-manager-worker-4.conf' do
  it { should be_file }
  its(:content) { should match /start on starting services-manager-worker/ }
end
