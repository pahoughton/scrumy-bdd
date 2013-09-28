#
# TestHost dependencies
#
node default {

  case $::osfamily {

    'Darwin': {
      package { ['python27',
                 'py27-pip',
                 'py-pip',
                 'python33',
                 'py33-pip'] :
        ensure   => 'installed',
        provider => 'macports',
      }
      # ugg more pip provider issues - macports is /opt/local/bin/pip
      file { '/usr/bin/pip' :
        ensure     => 'link',
        target     => '/opt/local/bin/pip-2.7',
      }
      package { ['nose',
                 'nose-cover3',
                 'nose-exclude'] :
        ensure   => 'installed',
        provider => 'pip',
        require  => File['/usr/bin/pip'],
      }
      # :( no support for pip-3 yet
      exec { ['install_nose3',
              'install_nose3-cover3',
              'install_nose3-exclude'] :
        command  => '/opt/local/bin/pip-3.3 install nose',
        require  => Package['py33-pip'],
      }
      package { ['libxml2',
                 'libxml2-dev',
                 'libxslt',
                 'libxslt-dev',
                 'ruby-full' ] :
        ensure   => 'installed',
      }->
      package { 'rspec-core' :
        ensure   => '2.13.0',
        provider => 'gem',
      }
    }

    'Debian': {

      package { ['python',
                 'python-pip',
                 'python3',
                 'python3-pip'] :
        ensure   => 'installed',
      }
      package { ['python-nose',
                 'nose-cover3',
                 'nose-exclude'] :
        ensure   => 'installed',
        provider => 'pip',
        require  => Package['python-nose'],
      }
      package { 'python3-nose' :
        ensure   => 'installed',
        require  => Package['python3'],
      }
      exec { ['install_nose3-cover3',
              'install_nose3-exclude'] :
        command  => '/usr/bin/pip-3.3 install nose-exclude',
        require  => Package['python3-pip'],
      }
      package { ['libxml2',
                 'libxml2-dev',
                 'libxslt1.1',
                 'libxslt1-dev',
                 'ruby-full' ] :
        ensure   => 'installed',
      }->
      package { 'rspec-core' :
        ensure   => '2.13.0',
        provider => 'gem',
      }
    }
    default: {

      package { ['python',
                 'python-pip',
                 'python3'] :
        ensure   => 'installed',
      }
      package { 'python3-pip' :
        ensure   => 'installed',
      }
      package { ['python-nose',
                 'python-nose-cover3',
                 'python-nose-exclude',
                 'PyYAML'] :
        ensure   => 'installed',
        require  => Package['python'],
      }
      package { ['python3-nose',
                 'python3-nose-cover3',
                 'python3-nose-exclude',
                 'python3-PyYAML'] :
        ensure   => 'installed',
        require  => Package['python3'],
      }
      package { ['libxml2',
                 'libxml2-devel',
                 'libxslt',
                 'libxslt-devel'] :
        ensure   => 'installed',
      }->
      package { 'ruby-devel' :
        ensure   => 'installed',
      }->
      package { 'rspec-core' :
        ensure   => '2.13.0',
        provider => 'gem',
      }
    }
  }

  package { ['bash','libtool','autoconf'] :
    ensure   => 'installed',
  }
  package { ['puppet',
             'puppet-lint',
             'rspec-puppet',
             'puppetlabs_spec_helper',
             'librarian-puppet'] :
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
