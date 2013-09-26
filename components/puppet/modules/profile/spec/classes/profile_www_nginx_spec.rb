require 'spec_helper'

describe 'profile::www_nginx' do

  it 'should ensure nginx present' do
    should contain_package( 'nginx' ).with({
      'ensure' => 'present',
    })
  end

  it 'should create config directories' do
    should contain_file('/etc/nginx/conf.d').with({
      'ensure' => 'directory',
    })
    should contain_file('/etc/nginx/locs.d').with({
      'ensure' => 'directory',
    })
  end

  it 'should create config file' do
    should contain_file('/etc/nginx/nginx.conf').
      with_content(/locs.d/)
  end

  it 'should ensure nginx is running' do
    should contain_service('nginx').with({
      'ensure' => 'running',
      'enable' => true,
    })
  end

  it 'should create the tmpfile conf for unix sockets directory' do
    should contain_file('/etc/tmpfiles.d/nginx.conf').
      with_content(/d\s+\/var\/run\/nginx\s+0775\s+nginx\s+nginx/)
  end
end
