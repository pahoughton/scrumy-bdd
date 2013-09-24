require 'spec_helper'

describe 'profile::trac' do

  let(:facts) {{
    :osfamily                 => 'RedHat',
    :postgres_default_version => '9.2',
  }}

  it 'should ensure trac system user exists' do
    should contain_user('trac').with({
      'ensure' => 'present',
      'gid'    => 'nginx',
      'groups' => 'git',
      'home'   => '/home/trac',
    })
  end

  it 'should ensure trac home directory exists' do
    should contain_file('/home/trac').with(
      'ensure'  => 'directory',
      'owner'   => 'trac',
      'group'   => 'nginx',
      'mode'    => '0755'
    )
  end

  it 'should generate id_rsa.pub file for gitolite access' do
    should contain_exec('ssh_keygen-trac').
      with_creates('/home/trac/.ssh/id_rsa')
  end

#   it 'should create a ssh id_pub file for gitolite access' do
#     should contain_file('/home/trac/.ssh/id_rsa.pub')
#   end

  it 'should add the trac user to gitolite' do 
    should contain_gitolite__user('trac')
  end

  it 'should ensure trac is installed' do
    should contain_package('trac').with_ensure('present')
  end

  it 'should add its location config to nginx' do
    should contain_file('/etc/nginx/locs.d/trac.conf').
      with_content(/tracd-dispatch.sock/)
  end

  it 'should create a tracd.service file' do
    should contain_file('/usr/lib/systemd/system/tracd.service').
      with_content(/User=trac/).
      with_content(/Group=nginx/).
      with_content(/UMask=006/).
      with_content(/tracd-dispatch.sock/)
  end

  it 'should enable and run trac_fcgi service' do
    should contain_service('tracd').with({
      'ensure' => 'running',
      'enable' => 'true',
    })
  end

  it 'should have a posgress trac user defined' do
    should contain_postgresql__database_user('trac').with({
      'createdb'    => true,
      'createrole'  => false,
    })
  end

  it 'should change the permisions of /etc/trac and /etc/trac/*' do
    should contain_file('/etc/trac').with(
      'ensure'  => 'directory',
      'owner'   => 'trac',
      'mode'    => '0755'
    )
    should contain_file('/etc/trac/plugins.d').with(
      'ensure'  => 'directory',
      'owner'   => 'trac',
      'mode'    => '0755'
    )
    should contain_file('/etc/trac/templates.d').with(
      'ensure'  => 'directory',
      'owner'   => 'trac',
      'mode'    => '0755'
    )
    should contain_file('/etc/trac/trac.ini').with(
      'ensure'  => 'exists',
      'owner'   => 'trac',
      'mode'    => '0644'
    )
    should contain_file('/etc/trac/enterprise-review-workflow.ini').with(
      'ensure'  => 'exists',
      'owner'   => 'trac',
      'mode'    => '0644'
    )
  end

  it 'install\'s http://trac-hacks.org/wiki/AcronymsPlugin plugin' do
    should contain_file('JUNK')
  end

  it 'install\'s includemacro' do
    should contain_file('JUNK')
  end

end
