#
# Class: profile
#
# Profiles represent feature sets such as database, www, devel ...

# base profile
class profile {
  package { 'xterm' :
    ensure => 'installed'
  }
  service { 'fprintd' :
    ensure => 'stopped',
    enable => false
  }
  $admin_email = 'paul4hough@gmail.com'
  file { '/etc/logwatch/conf/logwatch.conf' :
    ensure  => 'exists',
    content => template('profile/logwatch.conf.erb')
  }
}
