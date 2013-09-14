require 'spec_helper'

describe 'profile::bkup_server' do
  let(:facts) {{
    :osfamily                 => 'RedHat',
    :postgres_default_version => '9.2',
    :concat_basedir           => '/var/lib/puppet/concat',
  }}

  it 'should ensure bacula dir, sd and fd and console installed' do
    should contain_package('bacula-director')
    should contain_package('bacula-storage')
    should contain_package('bacula-client')
    should contain_package('bacula-console')
  end

  it 'should install config files' do
    should contain_file('/etc/bacula/bacula-dir.conf')
    should contain_file('/etc/bacula/bacula-fd.conf')
    should contain_file('/etc/bacula/bacula-sd.conf')
    should contain_file('/etc/bacula/bconsole.conf')
  end

  it 'should start bacula services (dir,sd &  fd)' do
    should contain_service('bacula-dir').with(
      'ensure'  => 'running',
      'enable'  => true
    )
    should contain_service('bacula-sd')
    should contain_service('bacula-fd')
  end

  it 'should create the bacula postgresql user as needed' do
    should contain_postgresql__database_user('bacula').with(
      'createdb'    => true,
      'createrole'  => false
    )
  end
  
  it 'should create the bacula postgresql db as needed' do
    should contain_postgresql__db('bacula').with(
      'user'    => 'bacula'
    )
  end

  it 'should grant read access to pgadmin user' do
    should contain_postgresql__grant('bacula-pgadmin').with(
      'role'      => 'pgadmin',
      'db'        => 'bacula',
      'privilege' => 'CONNECT'
    )
  end
  
end
