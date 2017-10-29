# -*- coding: UTF-8 -*-

import os, re, sys

recent_count = 9

rejects = [
  'COMMIT_EDITMSG', 'NetrwTreeListing', 'bash-fc-', '==[A-Z]',
  '\/private\/var\/', '\/mutt-' ]

paths = []
  #
for line in sys.stdin:
  m = re.match('\d+: ([^ \n]+)', line)
  if not m:
    continue
  if next((r for r in rejects if re.search(r, line)), None):
    continue
  paths.append(os.path.relpath(os.path.expanduser(m.group(1))))

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

# TODO

def print_flat(h, k):
  if len(h[k]) > 0:
    print k
    for path in h[k][0:-2]:
      print "├── %s" % path[len(k) + 1:]
    for path in h[k][-2:-1]:
      print "└── %s" % path[len(k) + 1:]

print_flat(tree, '..')
print_flat(tree, '/')

