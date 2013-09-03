require 'spec_helper'

describe 'profile' do
  it 'should ensure xterm is installed' do
    should contain_package('xterm').with_ensure('installed')
  end
end