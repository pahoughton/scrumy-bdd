# jenkins plugin install

define profile::jenkins_plugin (
  $jport        = '8085',
  $jenkins_home = '/var/lib/jenkins',
  $plugin       = $title
) {

  exec { "install jenkins plugin ${plugin}":
    command  => "java -jar ${jenkins_home}/jenkins-cli.jar -s http://localhost:${jport}/jenkins install-plugin ${plugin}",
    creates  => "${jenkins_home}/plugins/${plugin}.jpi",
    require  => Package['jenkins'],
  }
}