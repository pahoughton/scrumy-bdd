require 'spec_helper'

describe 'profile::jenkins' do
  it 'install jenkins' do
    should contain_package('jenkins').with_ensure('installed')
  end

  it 'create jenkins host user' do
  end

  it 'enable and start jenkins service running as jeninks user' do
    should contain_file('FAIL')
  end

  it 'create jenkins application user' do
  end

  it 'add ssh pub key to jenkins application user' do
  end

  #.....

  it 'configure libvirt for jenkins access' do
    should contain_file('/etc/polkit-1/localauthority/50-local.d/jenkins-virtd.pkla' ).
      with_content(/Allow jenkins libvirt clone permission/).
      with_content(/Identity=unix-user:jenkins/).
      with_content(/Action=org.libvirt.unix.manage/).
      with_content(/ResultAny=yes/).
      with_content(/ResultInactive=yes/).
      with_content(/ResultActive=yes/)
  end

  ['all-changes', 'analysis-collector', 'analysis-core', 'ansicolor',
  'build-alias-setter', 'buildcontext-capture', 'build-environment',
  'build-failure-analyzer', 'buildgraph-view',
  'build-monitor-plugin', 'buildresult-trigger', 'build-timeout',
  'collapsing-console-sections', 'compact-columns',
  'conditional-buildstep', 'custom-job-icon', 'dashboard-view',
  'disk-usage', 'email-ext', 'email-ext-recipients-column',
  'embeddable-build-status', 'emotional-jenkins-plugin', 'envinject',
  'extra-columns', 'extreme-feedback', 'gatling', 'git',
  'global-build-stats', 'greenballs', 'iphoneview',
  'jobConfigHistory', 'job-exporter', 'jobgenerator',
  'job-poll-action-plugin', 'libvirt-slave', 'livescreenshot',
  'log-command', 'log-parser', 'managed-scripts', 'mttr', 'pragprog',
  'PrioritySorter', 'project-stats-plugin', 'python', 'rake',
  'rich-text-publisher-plugin', 'scm-sync-configuration', 'scons',
  'shelve-project-plugin', 'sidebar-link', 'sitemonitor',
  'sloccount', 'ssh', 'ssh-agent', 'storable-configs-plugin',
  'tasks', 'template-project', 'text-finder', 'thinBackup',
  'timestamper', 'trac', 'trac-publisher-plugin', 'uptime',
  'warnings'].each do |p|
    it "install #{p} jenkins plugin" do
      should contain_profile__jenkins_plugin(p)
    end
  end


#   not available until fedora20
#   it 'configure jenkins access to clone, start, stop, undefine, vol-delete command' do
#     should contain_file('/etc/polkit-1/rules.d/100-jenkins-virtd.rules').
#       with_content('jenkins').
#       with_content('org.libvirt.api.domain.getattr').
#       with_content('org.libvirt.api.domain.read').
#       with_content('org.libvirt.api.domain.write').
#       with_content('org.libvirt.api.domain.start').
#       with_content('org.libvirt.api.domain.stop')
#   end
end
