require 'spec_helper'

describe 'profile::www' do

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

end
