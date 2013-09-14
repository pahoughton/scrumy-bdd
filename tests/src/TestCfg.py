'''Test configuration constants, functions ...
'''
import subprocess
import os
import unittest

TVM_ROOT_PART='may not need'
TVM_SWAP_PART='may not need'
TVM_HOSTNAME='cworld.local'
TVM_GITREPO_URL = 'git@cworld.local'

def product_topdir():
    '''return the project's top level directory (according to git)
    '''
    topdir = subprocess.check_output(['git','rev-parse','--show-toplevel']
                                     ).decode('utf-8').strip()
                                     
    if not os.path.isdir(topdir):
        raise Exception('Not a dir: '+topdir)
    return topdir

class TestThisModule(unittest.TestCase):
    def setup(self):
        pass
    
    def test_product_topdir(self):
        '''verify the product_topdir returns a valid directory
         
        The .git sub directory is check for existence
        '''
        topdir = product_topdir()
        self.assertTrue(os.path.isdir(os.path.join(topdir,'.git')), 
                        topdir + '/.git is not a directory')
        
if __name__ == '__man__':
    unittest.main()
