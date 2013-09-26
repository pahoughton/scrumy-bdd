require 'spec_helper'

$title = 'guser-gittest'
$pName = 'gittest'

describe 'gitolite::user', :type => 'define' do


  let :title do
    $title
  end

  # parameters
  let(:params) {{:name => $pName}}

  it 'contain user\'s public key file' do
    should contain_file('/home/git/admin/gitolite-admin/keydir/'+$pName+'.pub')
  end

  it 'should run the git clone as needed' do
    should contain_exec('git clone').with(
      'command' => 'git clone git@localhost:gitolite-admin'
    )
  end

  it 'should run the git pull to update gitolite-admin directory' do
    should contain_exec('git push').with(
      'command' => 'git push'
    )
  end

end
