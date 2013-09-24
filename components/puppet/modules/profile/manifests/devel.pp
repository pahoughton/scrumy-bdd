# devel base profile
class profile::devel {
  include gcc

  package { 'sloccount' :
    ensure => installed
  }

}
