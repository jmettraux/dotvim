
# fgrep.py

import re, sys

fname = sys.argv[1]

rex = sys.argv[2]
if rex[0] == '"' and rex[-1] == '"':
  rex = rex[1:-2]
if rex[1] == '/':
  rex = rex[1:-1]

f = open(fname, 'r')
ls = [ [ i + 1, l.rstrip() ] for i, l in enumerate(f.readlines()) ]
f.close

for i, l in ls:
  if re.search(rex, l):
    print('%5d %s' % (i, l))

