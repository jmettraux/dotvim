# -*- coding: UTF-8 -*-

# tree.py

import os, re, sys

fs = []


def compute_path():
  i = fs[-1]['i'] + 1
  d = []
  for f in fs[::-1]:
    if f['i'] < i:
      d.insert(0, f['n'])
      i = f['i']
  return os.path.join(*d)

for line in sys.stdin:

  line = line.strip()

  d = { 'l': line, 'i': -1 }
  fs.append(d);

  m = re.match(r'^([-|` ]+ )?([^\d].*)$', line)
  if m:
    i = len(m.group(1)) if m.group(1) else 0
    d['i'] = i
    d['n'] = m.group(2)
    d['p'] = compute_path()
    d['d'] = os.path.isdir(d['p'])

for f in fs:
  #print f
  if f['i'] < 0:
    print ' '.join([ f['l'], str(f['i']) ])
  else:
    print ' '.join([ f['l'], str(f['i']), f['p'], str(f['d']) ])

