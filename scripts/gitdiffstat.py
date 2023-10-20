# -*- coding: UTF-8 -*-

# gitdiffstat.py

import os, re, sys, subprocess

sha = sys.argv[1]

shalpha = subprocess.Popen('git rev-list HEAD | tail -1', shell=True, stdout=subprocess.PIPE
  ).stdout.read().strip()[0:7]

sha0 = sha + '^'
if shalpha == sha: sha0 = sha

cmd0 = 'git diff --numstat'
if sha != '0': cmd0 = cmd0 + ' ' + sha0 + ' ' + sha

cmd1 = 'git diff --name-status'
if sha != '0': cmd1 = cmd1 + ' ' + sha0 + ' ' + sha

cmd2 = 'git status'
if sha != '0': cmd2 = None

cmd3 = 'git diff --stat'
if sha != '0': cmd3 = cmd3 + ' ' + sha0 + ' ' + sha
cmd3 = cmd3 + ' | tail -1'

paths = {}

for line in subprocess.Popen(cmd0, shell=True, stdout=subprocess.PIPE).stdout:
  line = line.decode()
  m = re.match(r'^(\d+)\s+(\d+)\s+(.+)$', line)
  if not m: continue
  plus = m.group(1)
  minus = m.group(2)
  path = m.group(3)
  paths[path] = [ plus, minus, 'M' ]

for line in subprocess.Popen(cmd1, shell=True, stdout=subprocess.PIPE).stdout:
  line = line.decode()
  m = re.match(r'^D\s+(.+)$', line)
  if not m: continue
  g1 = m.group(1)
  if not paths.get(g1): paths[g1] = [ 0, 0, 'X' ]
  paths[g1][2] = 'D'

if cmd2:
  for line in subprocess.Popen(cmd2, shell=True, stdout=subprocess.PIPE).stdout:
    line = line.decode()
    m = re.match(r'^\s+(new file|deleted):\s+(.+)$', line)
    if m:
      #paths[m.group(1)][2] = 'A'
      a = paths.get(m.group(2))
      c = 'A'
      if m.group(1) == 'deleted': c = 'D'
      if a:
        a[2] = c
      else:
        paths[m.group(2)] = [ 0, 0, c ]
      continue
    m = re.match(r'^\s+renamed:\s+(.+) -> (.+)$', line)
    if m:
      a = paths.get(m.group(2))
      c = 'R'
      if a:
        a[2] = c
      else:
        paths[m.group(2)] = [ 0, 0, c ]
      #continue

lmax = 0
for path in paths.keys():
  lpath = len(path)
  if (lpath > lmax): lmax = lpath

#gitroot = subprocess.check_output([ 'git', 'rev-parse', '--show-toplevel' ]).strip()

for path in sorted(paths.keys()):
  a = paths[path]
  #path = os.path.relpath(os.path.join(gitroot, path))
  print(('%-' + str(lmax) + 's | %s+%s-%s') % (path, a[2], a[0], a[1]))

print
for line in subprocess.Popen(cmd3, shell=True, stdout=subprocess.PIPE).stdout:
  print(' ' + line.decode())
if sha != '0': print()

