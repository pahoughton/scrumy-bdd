#
# TestHost dependencies
#
node default {

  case $::osfamily {

    'Darwin': {
      package { 'python27' :
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
      package { 'python33' :
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
      package { 'nose' :
        ensure   => 'installed',
        provider => 'pip',
        require  => File['/usr/bin/pip'],
      }
      # :( no support for pip-3 yet
      exec { 'install_nose3' :
        command  => '/opt/local/bin/pip-3.3 install nose',
        require  => Package['py33-pip'],
      }
      package { 'nose-cover3' :
        ensure   => 'installed',
        provider => 'pip',
        require  => File['/usr/bin/pip'],
      }
      exec { 'install_nose3-cover3' :
        command  => '/opt/local/bin/pip-3.3 install nose-cover3',
        require  => Package['py33-pip'],
      }
      package { 'nose-exclude' :
        ensure   => 'installed',
        provider => 'pip',
        require  => Package['nose'],
      }
      exec { 'install_nose3-exclude' :
        command  => '/opt/local/bin/pip-3.3 install nose-exclude',
        require  => Package['py33-pip'],
      }
		  package { 'rspec-core' :
		    ensure   => '2.13.0',
		    provider => 'gem',
		  }->
		  package { 'libxslt-devel' :
		    ensure   => 'installed',
		  }->
		  package { 'libxslt' :
		    ensure   => 'installed',
		  }->
		  package { 'libxml2-devel' :
		    ensure   => 'installed',
		  }->
		  package { 'libxml2' :
		    ensure   => 'installed',
		  }
    }

    'Debian': {

      package { 'zfs-fuse' :
        ensure    => 'installed',
      }->
      service { 'zfs-fuse' :
        ensure    => 'running',
        enable    => true,
      }
      package { 'python' :
        ensure   => 'installed',
      }
      package { 'python-pip' :
        ensure   => 'installed',
      }
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
      package { 'nose-cover3' :
        ensure   => 'installed',
        provider => 'pip',
        require  => Package['python-nose'],
      }
      package { 'nose-exclude' :
        ensure   => 'installed',
        provider => 'pip',
        require  => Package['python-nose'],
      }
      package { 'python3-nose' :
        ensure   => 'installed',
        require  => Package['python3'],
      }
      exec { 'install_nose3-cover3' :
        command  => '/usr/bin/pip-3.3 install nose-cover3',
        require  => Package['python3-pip'],
      }
      exec { 'install_nose3-exclude' :
        command  => '/usr/bin/pip-3.3 install nose-exclude',
        require  => Package['python3-pip'],
      }
		  package { 'libxml2' :
		    ensure   => 'installed',
		  }->
      package { 'libxml2-dev' :
        ensure   => 'installed',
      }->
      package { 'libxslt1.1' :
        ensure   => 'installed',
      }->
      package { 'libxslt1-dev' :
        ensure   => 'installed',
      }->
      package { 'ruby-full' :
        ensure   => 'installed',
      }->
      package { 'rspec-core' :
        ensure   => '2.13.0',
        provider => 'gem',
      }
    }
    default: {

      package { 'zfs-fuse' :
        ensure    => 'installed',
      }->
      service { 'zfs-fuse' :
        ensure    => 'running',
        enable    => true,
      }
      package { 'python' :
        ensure   => 'installed',
      }
      package { 'python-pip' :
        ensure   => 'installed',
      }
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
      }
      package { 'libxml2' :
        ensure   => 'installed',
      }
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
      }
    }
  }

  package { 'bash' :
    ensure   => 'installed',
  }
  package { 'libtool' :
    ensure   => 'installed',
  }->
  package { 'autoconf' :
    ensure   => 'installed',
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
  package { 'rspec-mocks' :
    ensure   => '2.13.0',
    provider => 'gem',
    require  => Package['rspec-core']
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
