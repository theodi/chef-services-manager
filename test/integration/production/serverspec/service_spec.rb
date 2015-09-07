require 'serverspec'
set :backend, :exec

describe service 'services-manager-web-1' do
  it { should be_running }
end

describe port(3000) do
  it { should be_listening }
end

#describe command 'sudo apt-get install curl && curl --silent -I http://localhost:8001/members | grep "200 OK"' do
#  its(:stdout) { should match /200 OK/ }
#end

#describe command 'sudo apt-get install curl && curl --silent -I http://localhost/members | grep "200 OK"' do
#  its(:stdout) { should match /200 OK/ }
#end

#describe command 'wget -qO- http://localhost' do
#  its(:stdout) {should match /<title>ODI Member Directory<\/title>/ }
#end
