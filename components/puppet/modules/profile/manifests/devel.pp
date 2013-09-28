# devel base profile
class profile::devel {

  include gcc

  package { ['sloccount',
             'emacs',
             'xemacs',
             'xemacs-packages-extra'] :
    ensure => installed
  }

}
