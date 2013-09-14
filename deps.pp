#
# Setup a host to be capable of testing these modules and manifests
#
node default {
  package { 'puppet' :
    ensure   => 'installed',
    provider => 'gem',
  }
  package { 'rspec-puppet' :
    ensure   => 'installed',
    provider => 'gem',
  }
  package { 'puppetlabs_spec_helper' :
    ensure   => 'installed',
    provider => 'gem',
  }
  package { 'puppet-lint' :
    ensure   => 'installed',
    provider => 'gem',
  }
}
