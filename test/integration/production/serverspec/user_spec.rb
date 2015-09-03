require 'serverspec'
set :backend, :exec

describe user 'services-manager' do
  it { should exist }
end
