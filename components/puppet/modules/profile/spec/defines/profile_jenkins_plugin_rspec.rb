require 'spec_helper'

$title = 'trac'

describe 'profile::jenkins_plugin', :type => 'define' do

  context 'default params' do
    let(:title) {$title}

    it "install #{$title} plugin with defaults" do
      should contain_exec("install jenkins plugin #{$title}").
        with_creates(/#{$title}/).
        with_command(/#{$title}/)
    end
  end
  context 'specific params' do
    let(:title) {'fun plugin'}
    let(:params) {{
      :jport          => '1999',
      :jenkins_home   => '/home/jenkins',
      :plugin         => 'fun',
    }}
    it "install fun plugin using port 1999 and /home/jenkins" do
      should contain_exec("install jenkins plugin fun").
        with_creates(/\/home\/jenkins.*\/fun.jpi/).
        with_command(/:1999.* fun/)
    end
  end
end