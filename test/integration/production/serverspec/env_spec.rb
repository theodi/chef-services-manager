require 'serverspec'
set :backend, :exec

describe file '/home/services-manager/env' do
  it { should be_file }
end

#describe file '/home/certificates/certificates.theodi.org/current/.env' do
#  it { should be_symlink }
#  its(:content) { should match /SESSION_SECRET_CERTIFICATE: 8184842351530937c9c8c2e723fd03f4/ }
#end
