require 'spec_helper'

describe 'gitolite::rc', :type => 'define' do

  let(:title) {'title'}
    
  context 'with default parameters' do
    let(:facts) {{
      :hostname => 'cworld',
      :fqdn     => 'cworld.smk.com'
    }}
    it 'should create the gitolite.rc file with default values' do
      should contain_file('/home/git/.gitolite.rc').
      with_content(/UMASK\s+=>\s+0007/).
      with_content(/GIT_CONFIG_KEYS\s+=>\s+''/).
      with_content(/LOG_EXTRA\s+=>\s+1/).
      with_content(/SITE_INFO\s+=>\s+'Welcome to gitolite on cworld \(cworld.smk.com\).'/)
    end
  end
  context 'with jenkins config keys' do
    let(:facts) {{
      :hostname => 'cworld',
      :fqdn     => 'cworld.smk.com'
    }}
    # parameters
    let(:params) {{
      :umask       => '0077',
      :config_keys => 'gitolite\.url jenkins\.url jenkins\.build\.job jenkins\.build\.token',
      :log_extra   => 1,
      :site_info   => 'Please see http://blahblah/gitolite for more help'
    }}
  
    it 'should create the gitolite.rc file with the specified values' do
      should contain_file('/home/git/.gitolite.rc').
        with_content(/UMASK\s+=>\s+0077/).
        with_content(/GIT_CONFIG_KEYS\s+=>\s+'gitolite\\\.url jenkins\\\.url jenkins\\\.build\\\.job jenkins\\\.build\\\.token'/).
        with_content(/LOG_EXTRA\s+=>\s+1/).
        with_content(/SITE_INFO\s+=>\s+'Please see http:\/\/blahblah\/gitolite for more help'/)
    end
  end
end
