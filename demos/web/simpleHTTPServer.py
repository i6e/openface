from __future__ import print_function
import BaseHTTPServer
import SimpleHTTPServer
import sys


'''Adopted from https://www.piware.de/2011/01/creating-an-https-server-in-python/'''


def main(port):
    httpd = BaseHTTPServer.HTTPServer(('0.0.0.0', port), SimpleHTTPServer.SimpleHTTPRequestHandler)
    print('now serving http on port:', port)
    httpd.serve_forever()

if __name__ == '__main__':
    main(int(sys.argv[1]))
