#
# TestHost dependencies
#
node default {

  case $::osfamily {
    'Darwin': {
<<<<<<< HEAD
    
      package { 'python27' : 
=======

      package { 'python27' :
>>>>>>> test-fail
        ensure   => 'installed',
        provider => 'macports'
      }
      package { 'py27-pip' :
        ensure   => 'installed',
        provider => 'macports',
        require  => Package['python27']
      }
      package { 'py-pip' :
        ensure   => 'installed',
        provider => 'macports',
        require  => Package['py27-pip']
      }
<<<<<<< HEAD
        
      package { 'python33' : 
=======

      package { 'python33' :
>>>>>>> test-fail
        ensure   => 'installed',
        provider => 'macports'
      }
      package { 'py33-pip' :
        ensure   => 'installed',
        provider => 'macports',
        require  => Package['python33']
      }
      # ugg more pip provider issues - macports is /opt/local/bin/pip
      file { '/usr/bin/pip' :
        ensure     => 'link',
        target     => '/opt/local/bin/pip-2.7',
      }
<<<<<<< HEAD
      
      package { 'nose' : 
=======

      package { 'nose' :
>>>>>>> test-fail
        ensure   => 'installed',
        provider => 'pip',
        require  => File['/usr/bin/pip'],
      }
<<<<<<< HEAD
       
      # :( no support for pip-3 yet
      exec { 'install_nose3' : 
        command  => '/opt/local/bin/pip-3.3 install nose',
        require  => Package['py33-pip'],
      }
      package { 'nose-cover3' : 
=======

    # :( no support for pip-3 yet
      exec { 'install_nose3' :
        command  => '/opt/local/bin/pip-3.3 install nose',
        require  => Package['py33-pip'],
      }
      package { 'nose-cover3' :
>>>>>>> test-fail
        ensure   => 'installed',
        provider => 'pip',
        require  => Package['nose'],
      }
<<<<<<< HEAD
       
      exec { 'install_nose3-cover3' : 
        command  => '/opt/local/bin/pip-3.3 install nose-cover3',
        require  => Package['py33-pip'],
      }
      package { 'nose-exclude' : 
=======

      exec { 'install_nose3-cover3' :
        command  => '/opt/local/bin/pip-3.3 install nose-cover3',
        require  => Package['py33-pip'],
      }
      package { 'nose-exclude' :
>>>>>>> test-fail
        ensure   => 'installed',
        provider => 'pip',
        require  => Package['nose'],
      }
<<<<<<< HEAD
      exec { 'install_nose3-exclude' : 
=======
      exec { 'install_nose3-exclude' :
>>>>>>> test-fail
        command  => '/opt/local/bin/pip-3.3 install nose-exclude',
        require  => Package['py33-pip'],
      }
    }
<<<<<<< HEAD
    
    default: {
      package { 'python' : 
=======

    default: {

      package { 'zfs-fuse' :
        ensure    => 'installed',
      }->
      service { 'zfs-fuse' :
        ensure    => 'running',
        enable    => true,
      }
      package { 'python' :
>>>>>>> test-fail
        ensure   => 'installed',
      }
      package { 'python-pip' :
        ensure   => 'installed',
      }
<<<<<<< HEAD
      package { 'python3' : 
        ensure   => 'installed',
      }       
      package { 'python3-pip' :
        ensure   => 'installed',
      }
      
      package { 'python-nose' : 
        ensure   => 'installed',
        require  => Package['pthon'],
      }
      package { 'python-nose-cover3' : 
        ensure   => 'installed',
        require  => Package['pthon'],
      }
      package { 'python-nose-exclude' : 
        ensure   => 'installed',
        require  => Package['pthon'],
      }
      package { 'python3-nose' : 
        ensure   => 'installed',
        require  => Package['pthon3'],
      }
      package { 'python3-nose-cover3' : 
        ensure   => 'installed',
        require  => Package['pthon3'],
      }
      package { 'python3-nose-exclude' : 
        ensure   => 'installed',
        require  => Package['pthon3'],
=======
      package { 'python3' :
        ensure   => 'installed',
      }
      package { 'python3-pip' :
        ensure   => 'installed',
      }

      package { 'python-nose' :
        ensure   => 'installed',
        require  => Package['python'],
      }
      package { 'python-nose-cover3' :
        ensure   => 'installed',
        require  => Package['python'],
      }
      package { 'python-nose-exclude' :
        ensure   => 'installed',
        require  => Package['python'],
      }
      package { 'python3-nose' :
        ensure   => 'installed',
        require  => Package['python3'],
      }
      package { 'python3-nose-cover3' :
        ensure   => 'installed',
        require  => Package['python3'],
      }
      package { 'python3-nose-exclude' :
        ensure   => 'installed',
        require  => Package['python3'],
>>>>>>> test-fail
      }
    }
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
  package { 'puppet' :
    ensure    => 'installed',
    provider  => 'gem',
  }
  package { 'libxml2' :
    ensure   => 'installed',
  }->
  package { 'libxml2-devel' :
    ensure   => 'installed',
  }->
  package { 'libxslt' :
    ensure   => 'installed',
  }->
  package { 'libxslt-devel' :
    ensure   => 'installed',
  }->
  package { 'rspec-core' :
    ensure   => '2.13.0',
    provider => 'gem',
  }->
  package { 'rspec-mocks' :
    ensure   => '2.13.0',
    provider => 'gem',
  }->
  package { 'rspec-expectations' :
    ensure   => '2.13.0',
    provider => 'gem',
  }->
  package { 'rspec-system-serverspec' :
    ensure    => 'installed',
    provider  => 'gem',
  }
}
