# devel base profile
class profile::devel {
  #include gcc
  package { 'gcc' :
    ensure => 'installed'
  }
}
