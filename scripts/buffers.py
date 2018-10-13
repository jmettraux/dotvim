# -*- coding: UTF-8 -*-

# buffers.py

import os, re, sys


normals = []
specials = []

for line in sys.stdin:
  m = re.match(r'^(\d+)([^"]*)"([^"]+)"\s+line (\d+)', line.strip())
  if not(m):
    continue
  l = [ m.group(3) + ':' + m.group(4), m.group(1).rjust(3) ]
  if re.search(r'^_[a-z]___[a-zA-Z0-9_]', l[0]):
    specials.append(l)
  else:
    normals.append(l)

mx = 0
  #
for l in normals:
  mx = max(len(l[0]), mx)
for l in specials:
  mx = max(len(l[0]), mx)
  #
mx = mx + 1

for l in normals:
  print l[0].ljust(mx) + l[1]
for l in specials:
  print l[0].ljust(mx) + l[1]

