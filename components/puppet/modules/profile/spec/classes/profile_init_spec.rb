require 'spec_helper'

describe 'profile' do
  it 'should ensure xterm is installed' do
    should contain_package('xterm').with_ensure('installed')
  end
  
  it 'should stop and disable the finger print service (fprintd)' do
    should contain_service('fprintd').with(
      'ensure' => 'stopped',
      'enable' => false
    )
  end
  
end
