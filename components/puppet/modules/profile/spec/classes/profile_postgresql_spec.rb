require 'spec_helper'

describe 'profile::postgresql' do
  # note concat_basedir needed for concat module which is needed by 
  # the postgres module
  let(:facts) {{
    :osfamily                 => 'RedHat',
    :postgres_default_version => '9.2',
    :concat_basedir           => '/var/lib/puppet/concat',
  }}

  it 'should install postgresql package' do 
    should contain_package('postgresql-server').with({
      'ensure'  => 'present',
    })
  end

 it 'should ensure postgresql is running' do
    should contain_service('postgresqld').with({
      'ensure'     => 'running',
      'enable'     => true,
    })
  end

  it 'should configure postgres access' do
    should contain_file('/var/lib/pgsql/data/pg_hba.conf')
  end

  # Not the first time I've had problems with 'content' is nil in spec
  # testing - this is in an unknown fragment.
#   it 'should configure postgresql to listen to LAN connections' do 
#     should contain_file('/var/lib/pgsql/data/pg_hba.conf').
#       with_content(/local\s+all\s+all\s+peer/).
#       with_content(/host\s+all\s+all\s+10.0.1.1\/32\s+md5/)
#   end

  it 'should have a pgadmin user defined' do
    should contain_postgresql__database_user('pgadmin').with({
      'createdb'    => true,
      'createrole'  => true,
    })
  end

  it 'should have a pgtest user defined' do
    should contain_postgresql__database_user('pgtest').with({
      'createdb'    => false,
      'createrole'  => false,
    })
  end

end
