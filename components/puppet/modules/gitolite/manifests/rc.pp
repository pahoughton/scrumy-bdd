## gitolite rc (config file) type
define gitolite::rc (
  $umask='0007',
  $config_keys = '',
  $log_extra = 1,
  $site_info = "Welcome to gitolite on ${::hostname} (${::fqdn})."
) {

  file { '/home/git/.gitolite.rc' :
    ensure  => 'exists',
    content => template('gitolite/gitolite.rc.erb')
  }
}
