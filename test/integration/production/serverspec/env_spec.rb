require 'serverspec'
set :backend, :exec

describe file '/home/services-manager/env' do
  it { should be_file }
end

describe file '/home/services-manager/services-manager.theodi.org/current/.env' do
  it { should be_symlink }
end
