require 'spec_helper'

describe 'profile::bkup_server' do

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
    should contain_service('bacula-dir')
    should contain_service('bacula-sd')
    should contain_service('bacula-fd')
  end

end
