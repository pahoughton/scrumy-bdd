# Puppet entry point
#

node default {

  group { ['staff','testing','nginx','git'] :
    ensure  => 'present'
  }

  user { 'paul' :
    ensure      => 'present',
    comment     => 'Paul Houghton <paul4hough@gmail.com>',
    gid         => 'staff',
    groups      => ['staff','testing','nginx','git'],
  }

  class { 'gitolite' : }

  gitolite::user { 'paul' : }

  class { 'profile::devel' : }

}