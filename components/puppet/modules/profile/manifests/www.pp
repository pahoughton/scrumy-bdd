# www profile
class profile::www {
  # Note the puppetlabs-nginx module won't quite do what I want

  package { 'nginx' :
    ensure   => 'present',
  }

  $nginx_cfg_dir = '/etc/nginx'
  $nginx_cfg_locs_dir = "${nginx_cfg_dir}/locs.d"
  $nginx_cfg_hosts_dir = "${nginx_cfg_dir}/conf.d"

  file { $nginx_cfg_locs_dir:
    ensure => directory,
  }

  file { $nginx_cfg_hosts_dir:
    ensure => directory,
  }

  file { "${nginx_cfg_dir}/nginx.conf" :
    ensure  => file,
    content => template('profile/nginx.conf.erb'),
  }

  service { 'nginx' :
    ensure  => running,
    enable => true,
    require => [ File["${nginx_cfg_dir}/nginx.conf"], Package['nginx'] ],
  }
}
