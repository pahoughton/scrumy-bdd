'''Test basic system operation
'''
import unittest
import shutil
import subprocess as sp

class TestSysLocal(unittest.TestCase):

    def test_packages(self):
        '''Verify Packages installed
        '''
        for pkg in ['gcc','emacs','xemacs','sloccount']:
            fnd = shutil.which(pkg)
            if fnd:
                print('  Installed '+pkg)
            self.assertTrue(fnd,
                            'ERROR: missing '+pkg)
