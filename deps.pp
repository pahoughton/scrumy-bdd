#
# TestHost dependencies
#
node default {
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
  package { 'python' : 
    ensure   => 'installed',
  }
  package { 'python-nose' : 
    ensure   => 'installed',
  }
  package { 'python-nose-cover3' : 
    ensure   => 'installed',
  }
  package { 'python-nose-exclude' : 
    ensure   => 'installed',
  }
  package { 'python3' : 
    ensure   => 'installed',
  }
  package { 'python3-nose' : 
    ensure   => 'installed',
  }
  package { 'python3-nose-cover3' : 
    ensure   => 'installed',
  }
  package { 'python3-nose-exclude' : 
    ensure   => 'installed',
  }
}
