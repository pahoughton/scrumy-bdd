# test-gitolite_spec.rb - 2013-10-16 13:41
#
# Copyright (c) 2013 Paul Houghton <paul4hough@gmail.com>
#
require 'test_config'

describe 'Feature gitolite' do

  it 'provides gitolite server' do
    `ssh -i #{gl_key_file} #{gl_user}@#{gl_host} info`.should.
      include( 'gitolite-admin' )
  end

  it 'provides trac notification' do
    error('FIXME')
  end

  it 'provides jenkins notification' do
    error('FIXME')
  end

  it 'provides github mirroring' do
    error('FIXME')
  end
end
