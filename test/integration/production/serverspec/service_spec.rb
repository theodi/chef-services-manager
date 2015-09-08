require 'serverspec'
set :backend, :exec

describe service 'services-manager-web-1' do
  it { should be_running }
end

describe port(3000) do
  it { should be_listening }
end

describe command 'sudo apt-get install curl && curl --location --silent -I http://localhost:3000 | grep "200 OK"' do
  its(:stdout) { should match /200 OK/ }
end

describe command 'sudo apt-get install curl && curl --location --silent -I http://localhost | grep "401 Unauthorized"' do
  its(:stdout) { should match /401 Unauthorized/ }
end
