require 'spec_helper'

describe 'profile::devel' do
  let(:facts) {{
    :osfamily                 => 'RedHat',
    :operatingsystem          => 'Fedora',

  }}

  ['gcc','sloccount','emacs','xemacs'].each do |p|
    it "install #{p}" do
      should contain_package(p).with_ensure('installed')
    end
  end

end
