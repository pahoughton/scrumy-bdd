#!/usr/bin/env python3
'''
Full production installation of puppet master sysetm this will
also install updates as needed
'''
import subprocess
import logging as log
import argparse
import os
import filecmp
import shutil
import difflib


import puppetcfg


def appOptions():
    '''setup and process command line options
    returns argparse.
    '''
    appDesc = 'Install puppetmaster on curreht host system (requires root)'
    parser = argparse.ArgumentParser(description=appDesc)
    parser.add_argument('--run',
                        help='perform the install')
    parser.add_argument('--dry-run',
                        help='shows will happen when run (default)')
    return parser.parse_args()
    
class PMInstall(object):
    '''Puppet Master installation class
    '''
    
    def __init__(self):
        '''Get puppet configuration values
        '''
        self.pcfg = PuppetCfg()
        self.puppetModsFn = 'Puppetfile'
        
        self.puppetCfgFull = subprocess.check_output(['puppet',
                                                      'config',
                                                      'print']).decode('utf-8')
        
    def updatePuppetModules(self,dryRun):
        '''Update the modules used by our puppet manifests

        Updates are commited to Puppetfile.in that file is used to
        generate the puppet modules dir Puppetfile and install / update
        the modules as needed.
        '''
        pupLibModDir = self.pcfg.libModDir()
        if 'etc' in pupLibModDir:
            raise Exception('the last puppet module path puppet contains etc modify your cofiguration before proceeding (Man puppet.conf)')

        if not os.path.isdir(pupLibModDir):
            raise Exception('module path dir does not exist: '+pupLibModDir)
        
        pupModsInFn = self.puppetModsFn +'.in'
        if not os.path.isfile(pupModsInFn):
            raise Exception('input '+self.puppetModsFn+' missing')
        
        pupModsDestFn = os.path.join(pupLibModDir, self.puppetModsFn)
        doInstall = False
        if os.path.isfile(pupModsDestFn):
            if filecmp.cmp(pupModsInFn,pupModsDestFn, shallow=False):
                if os.path.getmtime(pupModsDestFn) > os.path.getmtime(pupModsInFn):
                    print('Local changes made to %s: are being overwritten' % pupModsDestFn )
                    
                doInstall = True
        else:
            doInstall = True;
            
        if doInstall:
            # simple copy for now - future, who knows but KISS
            self.curdir = os.getcwd()
            instModsCmd = ['librarian-puppet','install','--verbose']
            os.chdir(pupLibModDir)
            log.info('COPY: '+pupModsInFn,' to ',+pupModsDestFn)
            with open(pupModsDestFn) as fromf:
                fromlines = list(fromf)
                
            with open(pupModsInFn) as tof:
                tolines = list(tof)
                
            diff = difflib.context_diff(fromlines, tolines, fromfile=pupModsDestFn, tofile=pupModsInFn)
            diffmsg = ''
            for line in diff:
                diffmsg += line
            log.info('DIFF:\n'+diffmsg)
            log.info('RUNNIG: ',' '.join(instModsCmd))
            if not dryRun:
                shutil.copyfile(pupModsInFn,pupModsDestFn)
                if subprocess.call(instModsCmd):
                    raise Exception('FAILED: ',' '.join(instModsCmd))
                log.info('done')
            else:
                log.info('skipped - DRYRUN')
                

def main():
    '''application entry point'''
    args = appOptions();
    pminst = PMInstall()
    log.info('Starting installation / update')
    pminst.updatePuppetModules(args.run == False)
    log.info('Complete')
    exit( 0 )
    
    
    
if __name__ == '__main__':
    log.basicConfig(level=log.DEBUG)
    main()
    
