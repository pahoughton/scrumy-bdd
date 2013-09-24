require 'spec_helper'

describe 'profile::devel' do
  let(:facts) {{
    :osfamily                 => 'RedHat',
    :operatingsystem          => 'Fedora',
    
  }}

  it 'FAILS because the testing should use a for loop here' do
    should contain_package('FAIL')
  end

  it 'install gcc' do
    should contain_package('gcc').with_ensure('installed')
  end

  it 'install emacs' do
    should contain_package('emacs').with_ensure('installed')
  end

  it 'install xemacs' do
    should contain_package('xemacs').with_ensure('installed')
  end

end
