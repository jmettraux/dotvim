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

# escape spaces and parentheses
#
def escape_path(path):
  return re.sub(r'([ \(\)])', r'\\\1', path)


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
  path = escape_path(path)
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
  m = re.match(r'^.+ +.+ +.+ +.+ ([0-9.]+[BKMT]?) +.+ \d+ +[0-9:]+ +(.+)$', line)
  if m:
    path = escape_path(m.group(2))
    d[path] = m.group(2) + ' ' + m.group(1)
for path in paths:
  l = d.get(path, None)
  if l:
    print l
  #else:
  #  print "NOT FOUND: " + path

