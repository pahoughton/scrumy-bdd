import subprocess
import re
import os
import logging as log

class Cfg (object):
    '''Puppet configuration setings'''
    
    def __init__(self):
        '''Get puppet configuration values
        '''
        self.pcfg = {}        
        self.puppetCfgFull = subprocess.check_output(['puppet',
                                                      'config',
                                                      'print']).decode('utf-8')
    def value(self,varName):
        '''returns the value of the config variable as a string

        caching values as used.
        '''
        if varName not in self.pcfg:
            regx = re.compile(varName + ' = (.*)$', re.MULTILINE)
            rematch =  regx.search(self.puppetCfgFull);
            self.pcfg[varName] = rematch.group(1)

        return self.pcfg[varName]

    def libModDir(self):
        pupModDirs = self.value('modulepath').split(':')
        pupLibModDir = pupModDirs[-1]
        if 'etc' in pupLibModDir:
            raise Exception('the last puppet module path puppet contains etc modify your cofiguration before proceeding (Man puppet.conf)')

        if len(pupLibModDir) < 5:
            raise Exception('module path too short (<5chars): '+pupLibModDir)
        
        if not os.path.isdir(pupLibModDir):
            raise Exception('module path dir does not exist: '+pupLibModDir)

        return pupLibModDir
    
