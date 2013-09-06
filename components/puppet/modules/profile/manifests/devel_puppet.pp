# puppet development (configuration)
class profile::devel_puppet {
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
