# devel base profile
class profile::trac {

  package { 'trac' :
    ensure   => 'present',
    require  => [ Class['www'],
                  Package['postgresql'],
                  Package['python-psycopg2'],
                ]
  }

  $trac_fcgi_skdir = '/var/run/fcgi_nginx/'
  $trac_fcgi_socket = "unix:${trac_fcgi_skdir}/fcgi_nginx_trac.sock"

  file { '/etc/nginx/locs.d/trac.conf' :
    ensure  => 'exists',
    content => template('profile/nginx_trac_loc.conf.erb'),
  }

  file { '/usr/local/sbin/trac_fcgi.py' :
    ensure => 'exists',
    source => 'puppet:///modules/profile/trac_fcgi.py',
    mode   => '0755',
  }

  file { '/usr/lib/systemd/system/trac_fcgi.service' :
    ensure  => 'exists',
    content => template('profile/trac_fcgi.service.erb')
  }

  service { 'trac_fcgi' :
    ensure   => 'running',
    enable   => true,
    require  => File['/usr/local/sbin/trac_fcgi.py']
  }
}
