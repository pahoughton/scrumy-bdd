require 'spec_helper'

describe 'profile::devel' do
  it 'should ensure gcc is installed' do
    should contain_package('gcc').with_ensure('installed')
  end
end