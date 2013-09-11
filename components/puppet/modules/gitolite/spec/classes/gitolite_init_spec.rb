require 'spec_helper'

describe 'gitolite' do

  it 'should define the gitolite class' do
    should contain_class('gitolite')
  end

end
