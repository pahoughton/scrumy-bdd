import config
import unittest
import os

class TestHost(unittest.TestCase):

    def setUp(self):
        '''
        Verify VM config and vm is running. We don't want to run these
        test as root.

        Provide a tool that will verify test system has the needed VM
        tool set. Then perform all actions to get the VM up and running.
        
        '''
        if not os.path.isdir('../data'):
            raise Exception('../data is not a dir')

        

    def teardown(self):
        pass

    def test_host_exists(self):
        self.assertEqual(1,2,'nope 1 not 2')


if __name__ == '__main__':
    unittest.main()
