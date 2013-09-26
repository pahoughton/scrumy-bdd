require 'spec_helper'

$title = 'test_centos_6_4'

describe 'profile::virt_domain', :type => 'define' do

  let(:facts) {{
    :operatingsystem => 'CentOS'
  }}
  
  let :title do
    'test_centos_6_4'
  end

  # parameters
  #let(:params) {{ }}
 
  it 'create the kvm domain' do

    should contain_file( '/tmp/'+$title+'.virt.xml' ).
      with_content(/#{$title}/)

    should contain_file('/var/lib/puppet/files/centos-6.4-x86_64.domain.img')
    
  end

end
