#!/usr/bin/env python3.3
'''
Post receive hook for gitolite projects that want to notify jenkins
that a push has occured. It is up to jenkins to decided what to do about
the push. See: https://wiki.jenkins-ci.org/display/JENKINS/Git+Plugin

Note the only way to 'test' this is to create an entire environment (VM) and verify 
operation. Unit testing is just not possible.

Also note this script makes NO modifications, only sends output and an http request
to the jenkins.url

CPort$ git push -u origin devel
Counting objects: 3, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 277 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
remote: ARGS:
remote: ENV:
remote: XDG_SESSION_ID=68
remote: GIT_DIR=.
remote: SELINUX_ROLE_REQUESTED=
remote: GL_USER=pahoughton
remote: SHELL=/bin/bash
remote: GL_TID=29579
remote: GL_LOGFILE=/home/git/.gitolite/logs/gitolite-2013-08.log
remote: SSH_CLIENT=10.0.1.8 57376 22
remote: SELINUX_USE_CURRENT_RANGE=
remote: QT_GRAPHICSSYSTEM_CHECKED=1
remote: USER=git
remote: GL_REPO_BASE=/home/git/repositories
remote: PATH=/usr/libexec/git-core:/usr/libexec/git-core:/usr/libexec/git-core:/usr/libexec/git-core:/home/git/bin:/usr/local/bin:/usr/bin
remote: MAIL=/var/mail/git
remote: PWD=/home/git/repositories/pah_test_web_server.git
remote: LANG=en_US.UTF-8
remote: SELINUX_LEVEL_REQUESTED=
remote: GL_ADMIN_BASE=/home/git/.gitolite
remote: HOME=/home/git
remote: SHLVL=2
remote: SSH_ORIGINAL_COMMAND=git-receive-pack 'pah_test_web_server'
remote: LOGNAME=git
remote: CVS_RSH=ssh
remote: SSH_CONNECTION=10.0.1.8 57376 10.0.1.3 22
remote: LESSOPEN=||/usr/bin/lesspipe.sh %s
remote: GL_REPO=pah_test_web_server
remote: XDG_RUNTIME_DIR=/run/user/1001
remote: GL_BINDIR=/home/git/bin
remote: GL_LIBDIR=/home/git/bin/lib
remote: _=/usr/bin/env
remote: STDIN:
remote: O: 0000000000000000000000000000000000000000 N: a9fdf1bd416aa5f507b87c70d7b6f7a10ab2b1b2 R: refs/heads/devel
remote: OP: 0000000000000000000000000000000000000000
remote: NP: a9fdf1bd416aa5f507b87c70d7b6f7a10ab2b1b2
To git@cworld.local:pah_test_web_server
 * [new branch]      devel -> devel
Branch devel set up to track remote branch devel from origin.

making changes to test the hook.
test
'''
import sys
import os
import urllib.request
import subprocess

# FIXME - this needs be in some configuration system
# for both development and production
# 

JENKINS_URL = 'http://cworld.local/jenkins'

def show_post_receive_env():
    '''
    Show the user that did the push all the values available to the post-receive hook
    
    Values may be args (none expected), environment variables and read from stdin
    in the formation of: OLDREV NEWREV REFNAME
    '''
    print('ARGLIST:')
    for a in sys.argv:
        print('ARG: '+a)
        
    print('ENVLIST:')
    for k,v in os.environ.items():
        print('ENV: '+k+'='+v)
                
def get_branches():
    '''
    return a list of branches read from stdin
    '''
    branches = []
    for l in sys.stdin:
        oldref, newref, refname = l.split()
        branch = refname.split('/')[-1]
        branches.append(branch)

    return branches

def notify_jenkins(branches):
    '''Send notification to jenkins of the push
    
    Format: http://yourserver/jenkins/git/notifyCommit
                 ?url=<URL of the Git repository>[&branches=branch1[,branch2]*]
    
    This script gets two config values from your gitolite.conf file (see gitolite admin)
    you have to add these variables and the correct values to repositories that use
    this jenkins notification gitolite hook.
    
    Exmaple gitolite.conf repo entry
    repo @all
        config jenkins.url = http://cworld.local/jenkins
        config gitolite.url = git@cworld.local
    
    Also need to edit $GL_GITCONFIG_KEYS variable in ~/.gitolite.rc. on gitolite server
    
    
    '''
    uriBranchStr = ''
    if len(branches):
        uriBranchStr = '&branches='+','.join(branches)
    
    reqUrl = ''
    # note: GitPython does not work with python3
    reqUrl += subprocess.check_output(['git',
                                       'config',
                                        '--get',
                                        'jenkins.url']
                                      ).decode('utf-8').strip()
    reqUrl += '/git/notifyCommit?url='
              
    reqUrl += subprocess.check_output(['git',
                                       'config',
                                       '--get',
                                       'gitolite.url']
                                      ).decode('utf-8').strip()
            
    reqUrl += ':' + os.environ.get('GL_REPO')
    reqUrl += uriBranchStr

    resp = urllib.request.urlopen(reqUrl)
    if resp.status != 200:
        raise Exception('jenkins request failed: '+reqUrl + str(resp.status))
        
    print('Jenkins notified via: '+reqUrl)
    
    
def main():
     blist = get_branches()
     notify_jenkins(blist)
     
     
if __name__ == '__main__':
    main()
    
   