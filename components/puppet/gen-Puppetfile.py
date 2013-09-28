#!/usr/bin/env python3
'''Generate librarian-puppet Puppetfile

read all the .fixure.yml files and add the modules found
then find all my modules and adds them
'''
import os
import glob
import re
import subprocess as sp

import yaml

git_branch = os.environ.get('GIT_BRANCH')
if not git_branch:
    tmp = sp.check_output(['git',
                           'rev-parse',
                           '--abbrev-ref',
                           'HEAD']).decode('utf-8').strip()
    
git_repo = sp.check_output(['git',
                            'config',
                            '--get',
                            'remote.origin.url']).decode('utf-8').strip()


modules = dict()
for mdir in glob.glob('modules/*/manifests/init.pp' ):
    mod = re.sub('modules/(.*)/manifests/init.pp',r'\1',mdir)
    modules[mod] = {'repo': git_repo,
                    'ver':  git_branch,
                    'path': 'components/puppet/modules'}


for fn in glob.glob('modules/*/.fixtures.yml'):
    with open(fn,'r') as f:
        ydata = yaml.load(f)
        if ydata.get('fixtures') and ydata['fixtures'].get('repositories'):
            yrepos = ydata['fixtures']['repositories']
            for mod in yrepos:
                modules[mod] = {'repo': yrepos[mod]['repo']}
                if yrepos[mod].get('ref'):
                    modules[mod]['ver'] = yrepos[mod].get('ref')

mstr = ''
for mod in modules:
    repo = modules[mod]['repo']
    mstr += 'mod "{fmod}",\n  :git => "{frepo}",\n'.format(fmod=mod,
                                                         frepo=repo)
    if modules[mod].get('ver'):
        mstr += '  :ref => "{fver}",\n'.format(fver=modules[mod]['ver'])

    if modules[mod].get('path'):
        mstr += '  :path => "{fpath}",\n'.format(fpath=modules[mod]['path'])
    mstr = mstr[:-2]+"\n\n"

print( mstr )

