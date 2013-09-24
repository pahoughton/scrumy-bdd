require 'spec_helper'

describe 'profile::jenkins' do
  it 'install jenkins' do
    should contain_package('jenkins').with_ensure('installed')
  end

  it 'create jenkins host user' do
  end

  it 'enable and start jenkins service running as jeninks user' do
    should contain_file('FAIL')
  end

  it 'create jenkins application user' do
  end

  it 'add ssh pub key to jenkins application user' do
  end

  #..... 

  it 'configure libvirt for jenkins access' do
    should contain_file('/etc/polkit-1/localauthority/50-local.d/jenkins-virtd.pkla' ).
      with_content(/[Allow jenkins libvirt clone permission]/).
      with_content(/Identity=unix-user:jenkins]/).
      with_content(/Action=org.libvirt.unix.manage]/).
      with_content(/ResultAny=yes]/).
      with_content(/ResultInactive=yes]/).
      with_content(/ResultActive=yes]/)
  end

  it 'install libvirt-slave plugin' do

  end

#   not available until fedora20  
#   it 'configure jenkins access to clone, start, stop, undefine, vol-delete command' do
#     should contain_file('/etc/polkit-1/rules.d/100-jenkins-virtd.rules').
#       with_content('jenkins').
#       with_content('org.libvirt.api.domain.getattr').
#       with_content('org.libvirt.api.domain.read').
#       with_content('org.libvirt.api.domain.write').
#       with_content('org.libvirt.api.domain.start').
#       with_content('org.libvirt.api.domain.stop')
#   end
end
