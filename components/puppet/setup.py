#!/usr/bin/env python3
'''
Setup puppet in the puppet master host.

'''
import subprocess
import os
import logging as log

import puppetcfg

def setup():
    '''
    Perform host setup of puppet. Requires Redhat like system for now
    
    
    '''
    
    if subprocess.call(['yum','list','yum']):
        raise Exception('Yum not only Redhat like distributions support at this time')
    
    yumPackages = ['puppet',
                   'puppet-server']
    
    for pkg in yumPackages:
        cmd = ['yum','install',pkg]
        if subprocess.call(cmd):
            raise Exception('FAILED: ' + ' '.join(cmd))

    cmd = ['gem','install','librarian-puppet']
    if subprocess.call(cmd):
        raise Exception('FAILED: ' + ' '.join(cmd))
    
    pcfg = puppetcfg.Cfg()
    log.info('Puppet modules in: '+pcfg.libModDir())
    os.chdir(pcfg.libModDir())
    cmd = ['librarian-puppet','init']
    if subprocess.call(cmd):
        raise Exception('FAILED: ' + ' '.join(cmd))
        
if __name__ == '__main__':
    log.basicConfig(level=log.DEBUG)
    setup()
    
