# devel base profile
class profile::trac {

  $trac_fcgi_skdir = '/var/run/fcgi_nginx/'
  $trac_fcgi_socket_fn = "${trac_fcgi_skdir}/fcgi_nginx_trac.sock"

  user { 'trac' :
    ensure   => 'present',
    comment  => 'Trac Project Wiki',
    gid      => 'nginx',
    groups   => 'git',
    home     => '/home/trac',
  }
  ->
  file { '/home/trac' :
    ensure  => 'directory',
    owner   => 'trac',
    group   => 'nginx',
    mode    => '0755',
  }
  ->
  file { '/home/trac/.ssh' :
    ensure  => 'directory',
    owner   => 'trac',
    group   => 'nginx',
    mode    => '0700',
  }

  file { '/home/trac/products' :
    ensure  => 'directory',
    owner   => 'trac',
    group   => 'nginx',
    mode    => '0700',
    require => File['/home/trac'],
  }

  ssh_keygen{ 'trac' :
    require => File['/home/trac/.ssh']
  }
  ->
  gitolite::user{ 'trac' :
    name => 'trac',
  }

  package { 'trac' :
    ensure   => 'present',
    require  => [ Class['www'],
                  Package['postgresql'],
                  Package['python-psycopg2'],
                  Package['python-flup'],
                  Package['python-pip'],
                ]
  }
  ->
  file { '/etc/trac' :
    ensure   => 'directory',
    owner    => 'trac',
    mode     => '0755',
  }
  ->
  file { '/etc/trac/plugins.d' :
    ensure   => 'directory',
    owner    => 'trac',
    mode     => '0755',
  }
  ->
  file { '/etc/trac/templates.d' :
    ensure   => 'directory',
    owner    => 'trac',
    mode     => '0755',
  }

  file { '/etc/trac/enterprise-review-workflow.ini' :
    ensure  => 'exists',
    owner   => 'trac',
    mode    => '0644',
    require => File['/etc/trac'],
  }

  file { '/etc/trac/trac.ini' :
    ensure  => 'exists',
    owner   => 'trac',
    mode    => '0644',
    require => File['/etc/trac'],
  }

  file { '/etc/nginx/locs.d/trac.conf' :
    ensure  => 'exists',
    content => template('profile/nginx_trac_loc.conf.erb'),
  }

  file { '/usr/lib/systemd/system/trac_fcgi.service' :
    ensure  => 'exists',
    content => template('profile/trac_fcgi.service.erb')
  }

  # Note: trac db string: postgres://trac:pgsql@localhost/DBNAME
  postgresql::database_user  { 'trac' :
    password_hash => postgresql_password('pgadmin',extlookup('trac_pg_pass')),
    createdb      => true,
    require       => Class['postgresql::server'],
  }


  service { 'trac_fcgi' :
    ensure   => 'running',
    enable   => true,
    require  => File['/usr/lib/systemd/system/trac_fcgi.service'],
  }
}
