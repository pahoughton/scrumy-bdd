require 'spec_helper'

describe 'profile::devel_server' do
  it 'should include devel base class' do
    should include_class('profile::devel')
  end
end
