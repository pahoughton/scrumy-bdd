require 'spec_helper'

describe 'profile::postgresql' do
  # Not working on OS X :(
  # workaround error on mac os w/o postgressql
  let(:facts) {{
    :operatingsystem          => 'Fedora',
    :postgres_default_version => '9.2'
  }}
    
  it 'should ensure postgresql is running' do
    should contain_service('postgresql').with(
      'ensure'     => 'running',
      'enable'     => 'true',
      'hasrestart' => 'true' 
    )
  end
  it 'should configure postgresql to listen to LAN connections' do 
    should contain_file('/var/lib/pgsql/data/pg_hba.conf').
      with_content('local\s+all\s+all\s+peer').
      with_content('host\s+all\s+all\s+10.0.1.1/32\s+md5')
  end
  # no way to verify user creation.
end