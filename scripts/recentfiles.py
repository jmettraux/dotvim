# -*- coding: UTF-8 -*-

import os, re, sys, string, subprocess


rejects = [
  'COMMIT_EDITMSG', 'NetrwTreeListing', 'bash-fc-', '==[A-Z]',
  '\/private\/var\/', '\/mutt-' ]

def expand_path(path):
  p = os.path.relpath(os.path.expanduser(path))
  if re.match('\.\.\/\.\.\/', p):
    p = os.path.abspath(p)
  return p

paths = []
  #
for line in sys.stdin:
  m = re.match('\d+: ([^\n]+)', line)
  if not m:
    continue
  if next((r for r in rejects if re.search(r, line)), None):
    continue
  path = expand_path(m.group(1))
  if not os.path.isfile(path):
    continue
  paths.append(path)

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

print "== recent (%d)" % len(paths)

d = {}
cmd = 'ls -lh ' + string.join(paths)
  #
for line in subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).stdout:
  m = re.match('^.+ +.+ +.+ +.+ ([0-9.]+[BKMT]?) +.+ \d+ +[0-9:]+ +(.+)$', line)
  if m:
    d[m.group(2)] = m.group(2) + ' ' + m.group(1)
  #else:
  #  if re.match('^total \d+', line):
  #    continue
  #  print line
for path in paths:
  print d[path]

#print "== recent (tree)"
#
#def do_print_level(a, h, k):
#  v = h[k]
#  if len(v) > 0:
#    print "%s %s/" % (''.join(a), k)
#    aa = a[0:-1]
#    aa.append("│  ")
#    aa.append("├─")
#    print_level(aa, v)
#  else:
#    print "%s %s" % (''.join(a), k)
#
#def print_level(a, h):
#  ks = h.keys()
#  ks.sort()
#  for k in ks[0:-1]:
#    do_print_level(a, h, k)
#  for k in ks[-1:]:
#    aa = a[:-1]
#    aa.append("└─")
#    do_print_level(aa, h, k)
#
#print './'
#print_level([ "├─" ], tree['.'])
#
#def print_flat(h, k):
#  if len(h[k]) > 0:
#    print (k if k == '/' else "%s/" % k)
#    off = 1 if k == '/' else len(k) + 1
#    for path in h[k][0:-2]:
#      print "├── %s" % path[off:]
#    for path in h[k][-2:-1]:
#      print "└── %s" % path[off:]
#
#print_flat(tree, '..')
##print_flat(tree, '/')
#print "│"

