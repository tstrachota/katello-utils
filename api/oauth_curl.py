#!/usr/bin/python

import oauth2 as oauth
import urllib
import getopt
import sys



options, url = getopt.getopt(sys.argv[1:], 'd:m:k:s:u:', ['data=', 'method=', 'key=', 'secret=', 'user='])
for opt, arg in options:
    if opt in ('-d', '--data'):
        data = arg
    elif opt in ('-m', '--method'):
        method = arg
    elif opt in ('-k', '--key'):
        key = arg
    elif opt in ('-s', '--secret'):
        secret = arg
    elif opt in ('-u', '--user'):
        user = arg
url = url[0]


consumer = oauth.Consumer(key, secret)
client = oauth.Client(consumer)


headers = {
    'cp-user': user,
    'pulp-user': user,
    'Content-Type': 'application/json',
    'Accept': 'application/json'
}
#body = urllib.quote(data)
body = data

response = client.request(url, method=method, headers=headers, body=body)

print response[1]
