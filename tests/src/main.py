import unittest
import subprocess
import os
import psycopg2 as Pg

import TestCfg as cfg



class TestHost(unittest.TestCase):
    '''FIXME
    
    each component (bacula, fedora, postgres) needs its configuration information
    stored in this repository along with tests that verify the service is running.
    
    I'm only testing the operational status here. Is the service available.
    '''

    def setUp(self):
        '''
        Note not doing VM yet - working on Continuous integration first.
        
        Verify VM config and vm is running. We don't want to run these
        test as root.

        Provide a tool that will verify test system has the needed VM
        tool set. Then perform all actions to get the VM up and running.
        
        '''
        #if not os.path.isdir('../data'):
        #    raise Exception('../data is not a dir')

        

    def teardown(self):
        pass
    
    def test_gitolite(self):
        '''verify gitolite is responding. This requires the user running this test
        is a valid gitolite user else the test will fail
        '''
        self.assertEqual(subprocess.call(['ssh',cfg.TVM_GITREPO_URL,'info']),0,
                         'ssh '+cfg.TVM_GITREPO_URL+' info FAILED')
    
    def test_postgres(self):
        '''Can I connect to postgresql
        
        lets try to get pgpass to work for now
        '''
        self.assertTrue(os.path.isfile(os.path.expanduser('~/.pgpass')), 
                        '~/.pgpass required for postgress connection test.\n'+
                        '  it will need an entry like: '+cfg.TVM_HOSTNAME+
                        ':5432:*:pgtest:PASSWORD\n')
        
        conn = Pg.connect(host=cfg.TVM_HOSTNAME,
                                database='template1',
                                user='pgtest')
        self.assertEqual(conn.status, Pg.extensions.STATUS_READY, 
                         'Failed to connect to postgres')
        
        conn.close()
                                
    def test_bacula(self):
        '''I can't think of a possible remote test at this time
        
        Idea - snoop in bacula database and get last backup status
        '''
        conn = Pg.connect(host=cfg.TVM_HOSTNAME,
                                database='bacula',
                                user='pgtest')
        cur = conn.cursor()    
        cur.execute("SELECT count(*) from job where jobstatus = 'T'")
        row = cur.fetchone();
        self.assertTrue( row[0] >= 0,
                         'did not find bacula job table')
        
        

if __name__ == '__main__':
    unittest.main()
