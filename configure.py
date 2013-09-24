#!/usr/bin/env python
'''
Configure the system for installation.

yum required at this time
'''

class Configure (object):

    def config(self):
        yumPackages = ['python3',
                       ]
    
        for pkg in yumPackages:
            cmd = ['yum','install',pkg]
            if subprocess.call(cmd):
                raise Exception('FAILED: ' + ' '.join(cmd))

cfg = new Configure()
cfg.config();

print( 'Configuration done!' )

