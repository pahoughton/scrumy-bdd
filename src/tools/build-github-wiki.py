#!/usr/bin/env python3
'''Build github wiki pages from trac pages

FIXME - lots of hard coding
FIXME - command line arguments for pages
FIXME - destination directory
'''

import psycopg2
import sys
import pprint
import unittest
import re
import difflib

def get_wiki_page(conn, page):
    cursor = conn.cursor()

    # execute our Query
    wiki_test_q = '''
    SELECT text
    FROM wiki
    WHERE name = '{fpage}'
    AND   time = (SELECT max(time) FROM wiki WHERE name = '{fpage}')
    '''

    sql = wiki_test_q.format(fpage=page)

    print(sql)
    cursor.execute(sql)

    # retrieve the records from the database
    records = cursor.fetchall()

    return records[0][0]

def convert_trac_to_mw( page ):
    mwpage = re.sub('^[\t ]+\\*','*',page,0,re.MULTILINE)
    mwpage = re.sub(r'\[wiki:"(.+)" +([^]]+)\]',
                    r'[[\1 | \2]]',
                    mwpage,0)
    mwpage = re.sub(r'\[wiki:(\S+) +([^]]+)\]',
                    r'[[\1 | \2]]',
                    mwpage,0)
    mwpage = re.sub(r'\[wiki:(\S+)\]',
                    r'[[\1]]',
                    mwpage,0)
    return mwpage


def main():
    conn_string = "host='localhost' dbname='trac_scrumy_bdd' user='trac'"
    # print the connection string we will use to connect
    print "Connecting to database\n    ->%s" % (conn_string)

    # get a connection, if a connect cannot be made an exception will be raised here
    conn = psycopg2.connect(conn_string)

    orig = get_wiki_page(conn,'WikiStart')
    with open('WikiStart.trac','w') as f:
        f.write(orig)

    mw = convert_trac_to_mw( orig )
    with open('Home.mediawiki','w') as f:
        f.write(mw)

    # FIXME - hard coded pages
    for pg in ['Features','News']:
        orig = get_wiki_page(conn,pg)
        with open(pg+'.trac','w') as f:
            f.write(orig)

        mw = convert_trac_to_mw( orig )
        with open(pg+'.mediawiki','w') as f:
            f.write(mw)

    print 'ORIG:\n'
    print orig
    print 'NEW'
    print mw

class TestConvert(unittest.TestCase):

    def test_wiki_conv(self):
        '''
        Feature: convert trac wiki to GitHub mediawiki
        Scenario: mirror trac wiki pages to GitHub wiki
        '''
        tpg = '''
  * Everything is written down.
  * Nothing is repeated (duplication leads to inconsistencies).
  * Everything is reproducible.
  * All information is available from a central location (i.e. a web server).
  * All modifications are tracked (i.e. versioning), all history is kept.
  * All modifications are linked to the people that made them.
  * Connections between specification, code and validation are strictly maintained.

  stuff [wiki:"This Page" go here] more
  [wiki:APage]
  [wiki:PageTwo there]'''
        npg = convert_trac_to_mw(tpg)
        epg = '''
* Everything is written down.
* Nothing is repeated (duplication leads to inconsistencies).
* Everything is reproducible.
* All information is available from a central location (i.e. a web server).
* All modifications are tracked (i.e. versioning), all history is kept.
* All modifications are linked to the people that made them.
* Connections between specification, code and validation are strictly maintained.

  stuff [[This Page | go here]] more
  [[APage]]
  [[PageTwo | there]]'''

        if epg != npg:
            for blk in difflib.SequenceMatcher(a=epg, b=npg).get_opcodes():
                print( blk )
                if blk[0] == 'replace':
                    print( 'DIFF: ',epg[blk[1]:blk[2]],'!=',npg[blk[3]:blk[4]] )

        self.assertEquals( npg, epg )

    # conn.cursor will return a cursor object, you can use this cursor to perform queries
if __name__ == "__main__":
    #unittest.main()
    main()

