require 'spec_helper'

describe 'profile' do
  it 'should ensure xterm is installed' do
    should contain_package('xterm').with_ensure('installed')
  end
  
  it 'should stop the finger print service (fprintd)' do
    FAIL FIXME
  end
  
  it 'should disable the finger print service (fprintd)' do
    FAIL FIXME
  end
end
