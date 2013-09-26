# jenkins profile
# wget http://localhost:8085/jenkins/jnlpJars/jenkins-cli.jar
#
# NOTE: need to create git repo for config



# no CLI to delete plugins

  class profile::jenkins {

  package { 'jenkins' :
    ensure  => 'installed',
  }
  profile::jenkins_plugin {
    ['all-changes', 'analysis-collector', 'analysis-core',
    'ansicolor', 'build-alias-setter', 'buildcontext-capture',
    'build-environment', 'build-failure-analyzer', 'buildgraph-view',
    'build-monitor-plugin', 'buildresult-trigger', 'build-timeout',
    'collapsing-console-sections', 'compact-columns',
    'conditional-buildstep', 'custom-job-icon', 'dashboard-view',
    'disk-usage', 'email-ext', 'email-ext-recipients-column',
    'embeddable-build-status', 'emotional-jenkins-plugin',
    'envinject', 'extra-columns', 'extreme-feedback', 'gatling',
    'git', 'global-build-stats', 'greenballs', 'iphoneview',
    'jobConfigHistory', 'job-exporter', 'jobgenerator',
    'job-poll-action-plugin', 'libvirt-slave', 'livescreenshot',
    'log-command', 'log-parser', 'managed-scripts', 'mttr',
    'pragprog', 'PrioritySorter', 'project-stats-plugin', 'python',
    'rake', 'rich-text-publisher-plugin', 'scm-sync-configuration',
    'scons', 'shelve-project-plugin', 'sidebar-link', 'sitemonitor',
    'sloccount', 'ssh', 'ssh-agent', 'storable-configs-plugin',
    'tasks', 'template-project', 'text-finder', 'thinBackup',
    'timestamper', 'trac', 'trac-publisher-plugin', 'uptime',
    'warnings', ] : }

}
