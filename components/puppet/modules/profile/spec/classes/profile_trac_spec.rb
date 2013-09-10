require 'spec_helper'

describe 'profile::trac' do

  it 'should ensure trac is installed' do
    should contain_package('trac').with_ensure('present')
  end

  it 'should add its location config to nginx' do
    should contain_file('/etc/nginx/locs.d/trac.conf').
      with_content(/fcgi_nginx_trac.sock/)
  end

  it 'should create a trac_fcgi.py script' do
    should contain_file('/usr/local/sbin/trac_fcgi.py').
      with({
        'mode' => '0755',
      })
  end

  it 'should create a trac_fcgi.service file' do
    should contain_file('/usr/lib/systemd/system/trac_fcgi.service').
      with_content(/User=nginx/).
      with_content(/Group=nginx/).
      with_content(/UMask=006/).
      with_content(/fcgi_nginx_trac.sock/).
      with_content(/install.*fcgi_nginx/)
  end

  it 'shoud enable and run trac_fcgi service' do
    should contain_service('trac_fcgi').with({
      'ensure' => 'running',
      'enable' => 'true',
    })
  end
end
