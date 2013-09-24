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
	    require  => Package['nose'],
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
	}
	
    default: {
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
}
