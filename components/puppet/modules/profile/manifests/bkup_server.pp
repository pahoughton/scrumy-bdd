# backup server profile
#   can't use bacula module from puppetlabs because it does not support
#   postgres backend database. No support for most of the configuration
#   options yet. This is quick and dirty, the correct answer is to
#   add postgres support to the bacula module.
#
class profile::bkup_server {

  $bacula_conf_dir = '/etc/bacula'

  $bacula_dir_pass = extlookup('bacula_dir_pass')
  $bacula_sd_pass  = extlookup('bacula_sd_pass')
  $bacula_fd_pass  = extlookup('bacula_fd_pass')
  $bacula_db_user  = extlookup('bacula_db_user')
  $bacula_db_pass  = extlookup('bacula_db_pass')
  $bacula_db_name  = extlookup('bacula_db_name')

  package { 'bacula-storage':
    ensure => 'present',
  }
  package { 'bacula-director':
    ensure => 'present',
  }
  package { 'bacula-client':
    ensure => 'present',
  }
  package { 'bacula-console':
    ensure => 'present',
  }

  file { "${bacula_conf_dir}/bacula-dir.conf" :
    ensure  => 'exists',
    mode    => '0600',
    content => template('profile/bacula-dir.conf.erb'),
    require => Package['bacula-director'],
  }

  file { "${bacula_conf_dir}/bacula-sd.conf" :
    ensure  => 'exists',
    mode    => '0600',
    content => template('profile/bacula-sd.conf.erb'),
    require => Package['bacula-storage'],
  }

  file { "${bacula_conf_dir}/bacula-fd.conf" :
    ensure  => 'exists',
    mode    => '0600',
    content => template('profile/bacula-fd.conf.erb'),
    require => Package['bacula-client'],
  }

  file { "${bacula_conf_dir}/bconsole.conf" :
    ensure  => 'exists',
    mode    => '0600',
    content => template('profile/bconsole.conf.erb'),
    require => Package['bacula-console'],
  }

  postgresql::database_user  { 'bacula' :
    password_hash => postgresql_password('bacula',$bacula_db_pass),
    createdb      => true,
    require       => Class['postgresql::server'],
  }
  postgresql::db { 'bacula' :
    user     => 'bacula',
    password => $bacula_db_pass,
    require  => Postgresql__datatbase_user['bacula'],
  }
  postgresql::grant { 'bacula-pgadmin' :
    role      => 'pgadmin',
    db        => 'bacula',
    privilege => 'CONNECT'
  }

  service { 'bacula-dir' :
    ensure  => running,
    enable  => true,
    require => File["${bacula_conf_dir}/bacula-dir.conf"],
  }
  service { 'bacula-sd' :
    ensure  => running,
    enable  => true,
    require => File["${bacula_conf_dir}/bacula-sd.conf"],
  }
  service { 'bacula-fd' :
    ensure  => running,
    enable  => true,
    require => File["${bacula_conf_dir}/bacula-fd.conf"],
  }
}

