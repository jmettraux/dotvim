# -*- coding: UTF-8 -*-

import os, re, sys, string, subprocess

FNULL = open(os.devnull, 'w')


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

print("== recent (%d)" % len(paths))

def shellquote(s):
  return "'" + s.replace("'", "'\\''") + "'"

fs = {}

cmd = 'ls -lh ' + ' '.join(map(shellquote, paths))

for line in subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=FNULL).stdout:
  line = line.decode()
  m = re.match(
    r'^.+ +.+ +.+ +.+ ([0-9.]+[BKMT]?) +.+ \d+ +[0-9:]+ +(.+)$', line)
  if m:
    path = escape_path(m.group(2))
    #d[path] = m.group(2) + ' ' + m.group(1)
    fs[os.path.abspath(path)] = { 'p': m.group(2), 's': m.group(1) }

cf = open(os.path.join(os.path.dirname(__file__), 'countable.txt'), 'r')
exts = cf.read().split()
cf.close()
#print exts
tpaths = filter(lambda x: os.path.splitext(x)[1][1:] in exts, paths)
cmd = 'wc -l ' + ''.join(map(shellquote, tpaths))

for line in subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=FNULL).stdout:
  line = line.decode()
  if re.match('o such file', line): continue
  m = re.match('^\s+(\d+) (.+)$', line)
  if m == None: continue
  if m.group(2) == 'total': continue
  fs[os.path.abspath(m.group(2))]['l'] = m.group(1) + 'L'

cmd = 'git diff --numstat'
for line in subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=FNULL).stdout:
  ss = line.decode().strip().split()
  f = fs.get(os.path.abspath(ss[2]))
  if f == None: continue
  f['g'] = '+' + ss[0] + '-' + ss[1]

#for k in fs:
#  print("%s:" % k)
#  print(fs[k])

for path in paths:
  f = fs.get(os.path.abspath(path), None)
  if not f: continue
  print(' '.join(filter(None, [ f['p'], f['s'], f.get('l'), f.get('g') ])))

