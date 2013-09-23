#
# dependencies
#
# FIXME - this is becoming unwieldy and is very fedora centric.
# its time to use lists of packages and versions according to
# the operating system.
#
node default {
   package { 'python3-docutils' :
     ensure   => 'installed'
   }
   package { 'python3-markdown' :
     ensure   => 'installed'
   }

   package { 'scons' :
     ensure   => 'installed'
   }

   package { 'python3-paramiko' :
     ensure   => 'installed'
   }
   package { 'libvirt-python' :
     ensure   => 'installed'
   }

   package { 'rubygem-ruby-libvirt' :
     ensure   => 'installed'
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
