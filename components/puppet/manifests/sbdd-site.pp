# Puppet entry point
#

$extlookup_datadir = "/etc/puppet/manifests/extdata"
$extlookup_precedence = ["%{fqdn}", "domain_%{domain}","common","scrumy-bdd"]

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

  class { 'profile::devel' : }
  class { 'gitolite' : }

#  gitolite::user { 'paul' : }

}
