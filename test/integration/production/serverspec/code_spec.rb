require 'serverspec'
set :backend, :exec

%w{
  build-essential
  libcurl4-openssl-dev
}.each do |p|
  describe package p do
    it { should be_installed }
  end
end

describe file '/home/services-manager/services-manager.theodi.org' do
  it { should be_directory }
  it { should be_owned_by 'services-manager' }
end

describe file '/home/services-manager/.bundle/config' do
  it { should be_file }
  it { should be_owned_by 'services-manager' }
  its(:content) { should match /BUNDLE_BUILD__NOKOGIRI: --use-system-libraries/ }
end

describe file '/home/services-manager/services-manager.theodi.org/current/vendor/bundle' do
  it { should be_directory }
  it { should be_owned_by 'services-manager' }
end

describe file '/home/services-manager/services-manager.theodi.org/shared/log' do
  it { should be_directory }
  it { should be_owned_by 'services-manager' }
end
