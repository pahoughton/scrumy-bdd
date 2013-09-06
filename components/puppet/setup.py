'''
Setup puppet in the puppet master host.

'''
import subprocess

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
    


        
        # install via yum
        