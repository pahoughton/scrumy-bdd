'''
Full production installation of puppet master sysetm this will
also install updates as needed
'''
import subprocess
import re
import logging as log
import argparse

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
        self.pcfg = {}
        
        self.puppetCfgFull = subprocess.check_output(['puppet',
                                                      'config',
                                                      'print']).decode('utf-8')
        
    def puppetCfg(self,varName):
        '''returns the value of the config variable as a string

        caching values as used.
        '''
        if varName not in self.pcfg:
            log.debug('locating '+varName+' value')
            rematch = re.search(r'modulepath = (.*)$', self.puppetCfgFull);
            self.pcfg[varName] = rematch.group(1)

        return self.pcfg[varName]
        
    def updatePuppetModules(self,dryRun):
        '''Update the modules used by our puppet manifests

        Updates are commited to Puppetfile.in that file is used to
        generate the puppet modules dir Puppetfile and install / update
        the modules as needed.
        '''
        pupModDirs = self.puppetCfg('modulepath').split(':')
        pupLibModDir = pupModdirs[-1]
        if 'etc' in pupLibModDir:
            raise Exception('the last puppet module path puppet contains etc modify your cofiguration before proceeding (Man puppet.conf)')

        
        
        

def main():
    '''application entry point'''
    args = appOptions();
    pminst = new PMInstall(!args.run)
    
    exit 0;
    
    
    log.info('Starting installation / update')
    
if __name__ == '__main__':
    log.basicConfig(level=logging.DEBUG)
    
    
