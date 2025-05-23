# -*- coding: UTF-8 -*-

import os, re, sys, time, string, subprocess
import _common

W = int(sys.argv[1])

FNULL = open(os.devnull, 'w')


rejects = [
  'COMMIT_EDITMSG', 'NetrwTreeListing', 'bash-fc-', '==[A-Z]',
  r'\/private\/var\/', r'\/mutt-' ]


def expand_path(path):
  p = os.path.relpath(os.path.expanduser(path))
  if re.match(r'\.\.\/\.\.\/', p):
    p = os.path.abspath(p)
  return p

# escape spaces and parentheses
#
def escape_path(path):
  return re.sub(r'([ \(\)])', r'\\\1', path)


paths = []
  #
for line in sys.stdin:
  m = re.match(r'\d+: ([^\n]+)', line)
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
  if re.match(r'\/', path):
    tree['/'].append(path)
  elif re.match(r'\.\.\/', path):
    tree['..'].append(path)
  else:
    current = tree['.']
    for p in re.split(r'\/', path):
      if not (p in current):
        current[p] = {}
      current = current[p]

#
# write header
# so that errors are printed after it...

print("== recent (%d)" % len(paths))

def shellquote(s):
  return "'" + s.replace("'", "'\\''") + "'"

fs = {}

home = os.path.expanduser('~')
  #
def shorten_path(p):
  if p.startswith(home): return '~' + p[len(home):]
  return p

cmd = 'ls -lh ' + ' '.join(map(shellquote, paths))

for line in subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=FNULL).stdout:
  line = line.decode()
  m = re.match(
    r'^.+ +.+ +.+ +.+ ([0-9.]+[BKMT]?) +.+ \d+ +[0-9:]+ +(.+)$', line)
  if m:
    p = m.group(2)
    path = escape_path(p)
    fpath = os.path.abspath(path)
    fs[fpath] = { 'fp': fpath, 'sp': shorten_path(p), 'p': p, 's': m.group(1) }

cf = open(os.path.join(os.path.dirname(__file__), 'countable.txt'), 'r')
exts = cf.read().split()
cf.close()
#print(exts)
tpaths = filter(
  lambda x: os.path.splitext(x)[1][1:] in exts or os.path.split(x)[-1] in exts,
  paths)
cmd = 'wc -l ' + ' '.join(map(shellquote, tpaths))

for line in subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=FNULL).stdout:
  line = line.decode()
  if re.match('o such file', line): continue
  m = re.match(r'^\s+(\d+) (.+)$', line)
  if m == None: continue
  if m.group(2) == 'total': continue
  fs[os.path.abspath(m.group(2))]['l'] = m.group(1) + 'L'

cmd = 'git diff --numstat'
for line in subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=FNULL).stdout:
  ss = line.decode().strip().split()
  f = fs.get(os.path.abspath(ss[2]))
  if f == None: continue
  f['g'] = '+' + ss[0] + '-' + ss[1]

paths = [ os.path.abspath(p) for p in paths ]

for path in paths:
  f = fs.get(path, None)
  if not f: continue
  f['ag'] = _common.compute_mtime_age(path)

  # debugging...
  #
#for k in fs:
#  print("%s:" % k)
#  print(fs[k])

lsimax = 0
    #
for path in paths:
  f = fs.get(path, None)
  if not f: continue
  f['i'] = f['sp'].rfind('/')
  if f['i'] > lsimax: lsimax = f['i']
    #
for path in paths:
  f = fs.get(path, None)
  if not f: continue
  f['ip'] = (' ' * (lsimax - f['i'])) + f['sp']

#
# output

for path in paths:
  f = fs.get(path, None)
  if not f: continue
  s = f['ip']
  for p in filter(None, [ f['s'], f.get('l'), f.get('ag'), f.get('g') ]):
    s1 = s + ' ' + p
    if len(s1) > W: break
    s = s1
  print(s)

