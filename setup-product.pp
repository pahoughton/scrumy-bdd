# setup-product.pp - 2013-10-14 06:24
#
# Copyright (c) 2013 Paul Houghton <paul4hough@gmail.com>
#
Package {
  provider => $osfamily ? {
    'Darwin'  => macports,
    default   => undef,
  }
}
case $::osfamily {
  'RedHat' : {
    $pkg_list = ['ruby-devel']
  }
  default : {
    $pkg_list = ['ruby-full']
  }
}
package { $pkg_list :
  ensure    => 'installed',
}
package { ['rspec-core',
          'puppet',
          'puppet-lint',
          'rspec-puppet',
          'puppetlabs_spec_helper',
          'librarian-puppet'] :
  ensure    => 'installed',
  provider  => 'gem',
}


case $::osfamily {
  'Darwin': {
    $pkg_list = ['ruby-full']
    $pkg_provider = 'macports'
  }
  'Debian' : {
    $pkg_list = ['ruby-full']
    $pkg_provider = undef
  }
  'RedHat' : {
    $pkg_list = ['ruby-devel']
    $pkg_provider = undef
  }
  default : {
    $pkg_list = ['ruby-full']
    $pkg_provider = undef
  }
}
package { $pkg_list :
  ensure    => 'installed',
  provider  => $pkg_provider,
}
package { ['rspec-core',
          'puppet',
          'puppet-lint',
          'rspec-puppet',
          'puppetlabs_spec_helper',
          'librarian-puppet'] :
  ensure    => 'installed',
  provider  => 'gem',
}

package { ['boto'] :
  ensure    => 'installed',
  provider  => 'pip',
}
