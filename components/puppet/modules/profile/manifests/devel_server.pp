# devel server
class profile::devel_server {
  class { 'profile::devel' :  }
  #class { 'profile::bugzilla' }
  #class { 'trac' }
}
