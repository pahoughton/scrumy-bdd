require 'spec_helper'

describe 'profile::virt_host' do

  it 'install virsh' do
    should contain_package('libvirt').with_ensure('installed')
  end

  it 'create user virtmgr for ssh management' do
  end

  it 'configure libvirt for virtmgr access' do
    should contain_file('/etc/polkit-1/localauthority/50-local.d/jenkins-virtd.pkla' ).
      with_content(/[Allow virtmgr libvirt management permission]/).
      with_content(/Identity=unix-user:virtmgr]/).
      with_content(/Action=org.libvirt.unix.manage]/).
      with_content(/ResultAny=yes]/).
      with_content(/ResultInactive=yes]/).
      with_content(/ResultActive=yes]/)
  end


end
