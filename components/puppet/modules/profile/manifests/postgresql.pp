# postgresql profile
class profile::postgresql {
  class { 'postgresql::server':
    config_hash => {
      'ip_mask_allow_all_users'    => '10.0.1.1/32',
      'listen_addresses'           => '*',
      'manage_redhat_firewall'     => true,
      'manage_pg_hba_conf'         => true,
    }
  }
  postgresql::database_user  { 'pgadmin' :
    password_hash => postgresql_password('pgadmin',extlookup('pgadmin_pass')),
    createdb      => 'True',
    createrole    => 'True',
    require       => Class['postgresql::server'],
  }
  postgresql::database_user  { 'pgtest' :
    password_hash => postgresql_password('pgtest',extlookup('pgtest_pass')),
    createdb      => 'True',
    createrole    => 'True',
    require       => Class['postgresql::server'],
  }
}
