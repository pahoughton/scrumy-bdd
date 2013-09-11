# gitolite user type
define gitolite::user (
  $name
) {

  $gl_home_dir   = '/home/git'
  $gl_admin_dir = "${gl_home_dir}/admin/gitolite-admin"


  file { '/home/git/admin' :
    ensure => 'directory',
  }

  exec { 'git pull' :
    command => 'git pull',
  }

  exec { 'git clone' :
    command => 'git clone git@localhost:gitolite-admin',
    cwd     => '/home/git/admin',
    require => File['/home/git/admin'],
  }

  file { '${gl_admin_dir}' : 
    require => Exec['git clone'],
  }

  file { '${gl_admin_dir}/keydir' :
    require => [ File['${gl_admin_dir}'],
                 Exec['git pull'],
               ]
  }

  exec { 'git add' :
    command => 'git add ${name}.pub',
    cwd     => '${gl_admin_dir}/keydir',
  }
  ->
  exec { 'git commit' :
    command => "git commit -m 'Added ${name}'",
    cwd     => '${gl_admin_dir}/keydir',
  }
  ->
  exec { 'git push' :
    command => 'git push',
    cwd     => "${gl_admin_dir}/keydir",
  }

  file { "${gl_admin_dir}/keydir/${name}.pub" :
    ensure => 'exists',
    source => "/home/$name/.ssh/id_rsa.pub",
    owner  => 'git',
    notify => Exec['git push'],
  }

}
