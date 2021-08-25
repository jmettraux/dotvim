
# cat.py

import re, sys

fn = sys.argv[1]
f = open(fn, 'r')
ls = f.readlines()
f.close

for l in ls:
  if re.match('^#', l):
    continue
  print(l)

