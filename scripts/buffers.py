# -*- coding: UTF-8 -*-

# buffers.py

import os, re, sys

print "== buffers"

for line in sys.stdin:
  m = re.match(r'^(\d+)([^"]*)"([^"]+)"\s+line (\d+)', line.strip())
  if not(m):
    continue
  print m.group(3) + ':' + m.group(4) + '  ' + m.group(1)

