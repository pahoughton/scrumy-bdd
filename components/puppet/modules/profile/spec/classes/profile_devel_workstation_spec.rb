require 'spec_helper'

describe 'profile::devel_workstation' do
  it 'should include devel base class' do
    should include_class('profile::devel')
  end
end
