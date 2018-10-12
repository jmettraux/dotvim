# -*- coding: UTF-8 -*-

# grep.py

import os, re, sys


path = None

for line in sys.stdin:
  m = re.match(r'^([^:]+):(\d+):(.+)$', line)
  if not(m):
    print 'grep.py choked on >>' + line.strip() + '<<'
  else:
    pa = os.path.relpath(m.group(1))
    if pa != path:
      print pa
      path = pa
    print '%5d|%s' % (int(m.group(2)), m.group(3))

