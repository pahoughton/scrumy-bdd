#!/usr/bin/env python
'''Run trac connecting through a unix stream socket using fcgi
'''
import os
import sys


if len(sys.argv) != 2 :
    print('%s unix:/path/to/socket.sock' % (sys.argv[0]))
    exit(1)

sockaddr = sys.argv[1]
#os.environ['TRAC_ENV'] = '/home/trac/instance'

try:
     from trac.web.main import dispatch_request
     import trac.web._fcgi

     fcgiserv = trac.web._fcgi.WSGIServer(dispatch_request, 
          bindAddress = sockaddr, umask = 7)
     fcgiserv.run()

except SystemExit:
    raise
except Exception, e:
    print 'Content-Type: text/plain\r\n\r\n',
    print 'Oops...'
    print
    print 'Trac detected an internal error:'
    print
    print e
    print
    import traceback
    import StringIO
    tb = StringIO.StringIO()
    traceback.print_exc(file=tb)
    print tb.getvalue()

