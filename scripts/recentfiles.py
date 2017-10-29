# -*- coding: UTF-8 -*-

import os, re, sys

recent_count = 14

rejects = [
  'COMMIT_EDITMSG', 'NetrwTreeListing', 'bash-fc-', '==[A-Z]',
  '\/private\/var\/', '\/mutt-' ]

def expand_path(path):
  p = os.path.relpath(os.path.expanduser(path))
  if re.match('\.\.\/\.\.\/', p):
    p = os.path.abspath(path)
  return p

paths = []
  #
for line in sys.stdin:
  m = re.match('\d+: ([^ \n]+)', line)
  if not m:
    continue
  if next((r for r in rejects if re.search(r, line)), None):
    continue
  paths.append(expand_path(m.group(1)))

tree = { '/': [], '..': [], '.': {} }
  #
for path in paths:
  if re.match('\/', path):
    tree['/'].append(path)
  elif re.match('\.\.\/', path):
    tree['..'].append(path)
  else:
    current = tree['.']
    for p in re.split('\/', path):
      if not (p in current):
        current[p] = {}
      current = current[p]

print "== recent (%d)" % recent_count

for path in paths[0:recent_count]:
  print path

print "== recent (tree)"

def print_level(a, h):
  for k in h:
    if len(h[k]) > 0:
      print "%s %s/" % (''.join(a), k)
      aa = a[0:-1]
      aa.append("│  ")
      aa.append("├─")
      print_level(aa, h[k])
    else:
      print "%s %s" % (''.join(a), k)

print './'
print_level([ "├─" ], tree['.'])

def print_flat(h, k):
  if len(h[k]) > 0:
    print (k if k == '/' else "%s/" % k)
    off = 1 if k == '/' else len(k) + 1
    for path in h[k][0:-2]:
      print "├── %s" % path[off:]
    for path in h[k][-2:-1]:
      print "└── %s" % path[off:]

print_flat(tree, '..')
print_flat(tree, '/')

