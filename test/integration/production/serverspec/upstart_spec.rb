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
  its(:md5sum) { should eq '5c239a7ba0a1358d3324f7c1ee0d842a' }
end

describe file '/etc/init/services-manager-scheduler-1.conf' do
  it { should be_file }
  its(:content) { should match /start on starting services-manager-scheduler/ }
  its(:md5sum) { should eq '1352baa5592d3f8e5f6230f62c674576' }
end

describe file '/etc/init/services-manager-worker-4.conf' do
  it { should be_file }
  its(:content) { should match /start on starting services-manager-worker/ }
  its(:md5sum) { should eq '36a07a64e85a1f8952c978cb7d7b6d5a' }
end

###
###describe file '/etc/init/services-manager-thin-1.conf' do
###  it { should be_file }
###  its(:content) { should match /start on starting services-manager-thin/ }
###  its(:content) { should match /exec su - services-manager -c/ }
###  its(:content) { should match /PORT=8001/ }
###  its(:content) { should match /RACK_ENV=production/ }
###  its(:content) { should match /RAILS_ENV=production/ }
###  its(:content) { should match /bundle exec thin start -p \$PORT >> \/var\/log\/services-manager\/thin-2.log 2>&1/ }
###end
