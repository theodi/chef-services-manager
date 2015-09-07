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
  its(:md5sum) { should eq '12b6e99f7c65321cc4cf615f44c7b13c' }
end

describe file '/etc/init/services-manager-scheduler-1.conf' do
  it { should be_file }
  its(:content) { should match /start on starting services-manager-scheduler/ }
  its(:md5sum) { should eq 'bb27883840f509157868abdf1ced8253' }
end

describe file '/etc/init/services-manager-worker-4.conf' do
  it { should be_file }
  its(:content) { should match /start on starting services-manager-worker/ }
  its(:md5sum) { should eq '37527e7fff53c8facc7e429863a9f81c' }
end
