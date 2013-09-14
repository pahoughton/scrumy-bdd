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
}
