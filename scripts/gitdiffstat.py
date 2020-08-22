# -*- coding: UTF-8 -*-

# gitdiffstat.py

import os, re, sys, subprocess

sha = sys.argv[1]

cmd0 = 'git diff --numstat'
if sha != '0': cmd0 = cmd0 + ' ' + sha + '^ ' + sha

cmd1 = 'git diff --name-status'
if sha != '0': cmd1 = cmd1 + ' ' + sha + '^ ' + sha

cmd2 = 'git status'
if sha != '0': cmd2 = None

paths = {}

for line in subprocess.Popen(cmd0, shell=True, stdout=subprocess.PIPE).stdout:
  m = re.match(r'^(\d+)\s+(\d+)\s+(.+)$', line)
  plus = m.group(1)
  minus = m.group(2)
  path = m.group(3)
  paths[path] = [ plus, minus, 'M' ]

for line in subprocess.Popen(cmd1, shell=True, stdout=subprocess.PIPE).stdout:
  m = re.match(r'^D\s+(.+)$', line)
  if not m: continue
  paths[m.group(1)][2] = 'D'

if cmd2:
  for line in subprocess.Popen(cmd2, shell=True, stdout=subprocess.PIPE).stdout:
    m = re.match(r'^\s+(new file|deleted):\s+(.+)$', line)
    if not m: continue
    #paths[m.group(1)][2] = 'A'
    a = paths.get(m.group(2))
    c = 'A'
    if m.group(1) == 'deleted': c = 'D'
    if a:
      a[2] = c
    else:
      paths[m.group(2)] = [ 0, 0, c ]

lmax = 0
for path in paths.keys():
  lpath = len(path)
  if (lpath > lmax): lmax = lpath

for path in sorted(paths.keys()):
  a = paths[path]
  print ('%-' + str(lmax) + 's | %s+%s-%s') % (path, a[2], a[0], a[1])

