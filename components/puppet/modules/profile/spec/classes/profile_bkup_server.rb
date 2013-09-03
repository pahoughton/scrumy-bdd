require 'spec_helper'

describe 'profile::bkup_server' do
  it 'should ensure xterm is installed' do
    should contain_package('bacula-director').with_ensure('installed')
    should contain_package('bacula-storage').with_ensure('installed')
    should contain_file('/etc/bacula/bacula-dir.conf') \
            .with_content(/^\s*FIXME$/)
  end
end