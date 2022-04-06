# -*- coding: UTF-8 -*-

# tree.py

import os, re, sys, string, subprocess


# determine root

root = sys.argv[1]
if os.path.isfile(root): root = os.path.dirname(root)
if root[-1] != '/': root = root + '/'

# determine git root

gitroot = False
try:
  DEV_NULL = open(os.devnull, 'w')
  gitroot = subprocess\
    .check_output([ 'git', 'rev-parse', '--show-toplevel' ], stderr=DEV_NULL)\
    .decode()\
    .strip()
except:
  True # not a git repo

# gather git stats

git = {}

if gitroot:

  cmd = 'git diff --numstat'
  for line in subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).stdout:
    line = line.decode().strip()
    #print([ 'gdns', line ])
    ss = line.split()
    #print([ gitroot, ss[2] ])
    ap = os.path.abspath(os.path.join(gitroot, ss[2]))
    git[ap] = { 'p': ss[2], 'a': ss[0], 'd': ss[1] }

  cmd = 'git status -s'
  for line in subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).stdout:
    line = line.decode().strip()
    #print([ 'gss', line ])
    ss = line.split()
    if len(ss) > 2 and ss[2] == '->':
      ap = os.path.abspath(ss[3])
      g = git.get(ap, { 'p': ss[3] })
      git[ap] = g
      g['s'] = ss[0]
    else:
      ap = os.path.abspath(ss[1])
      g = git.get(ap, { 'p': ss[1] })
      git[ap] = g
      g['s'] = ss[0]

#print(git)
#print(git.keys())
#print git['/home/jmettraux/w/sg/ispec/spec/common_spec.rb']

cf = open(os.path.join(os.path.dirname(__file__), 'countable.txt'), 'r')
exts = cf.read().split()
cf.close()

wcl = {}
cmd = (
  'find ' + root + ' ' +
  ' -o '.join(
    map(
      lambda x: '-name "*.' + x + '" ',
      exts)) +
  ' | xargs wc -l 2>/dev/null')
for line in subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).stdout:
  ss = line.decode().strip().split()
  if len(ss) < 2: continue
  if ss[1] == 'total': continue
  if re.match(r'\/\.git\/', ss[1]): continue
  wcl[os.path.abspath(ss[1])] = ss[0]


# do the tree

fs = []

def to_kmgt(s): # https://stackoverflow.com/questions/12523586
  step_unit = 1024.0
  for x in [ '', 'K', 'M', 'G', 'T' ]:
    #if s < step_unit: return "%3.1f%s" % (s, x)
    if s < step_unit: return "%i%s" % (s, x)
    s /= step_unit

def compute_size(path):
  m = re.match(r'^([^*]+)', path)
  if m == None: return '-1'
  pa = m.group(1)
  if os.path.exists(pa) == False: return '-1'
  return to_kmgt(os.path.getsize(pa))

def compute_path():
  i = fs[-1]['i'] + 1
  d = []
  for f in fs[::-1]:
    if f['i'] < i:
      d.insert(0, f['n'])
      i = f['i']
  return os.path.join(*d)

def walk(path, i, prefix):

  fns = sorted(os.listdir(path))

  dfns = []
  ffns = []
    #
  for fn in fns:
    if fn[0:1] == '.':
      1
    elif os.path.isdir(os.path.join(path, fn)):
      dfns.append(fn)
    else:
      ffns.append(fn)

  for fn in ffns + dfns:

    if fn[0:1] == '.': continue

    h = { 'i': i, 'n': fn }
    h['p'] = os.path.join(path, fn)
    h['d'] = os.path.isdir(h['p'])
    h['s'] = compute_size(h['p'])
    h['L'] = wcl.get(os.path.abspath(h['p']))
    pre = prefix
    if fn == fns[-1]:
      pre = re.sub('\|-- $', '`-- ', prefix)
      prefix = re.sub('\|-- $', '    ', prefix)
    h['l'] = pre + fn + ('/' if h['d'] else '')

    fs.append(h)

    if h['d']: walk(h['p'], i + 1, prefix[0:-3] + '   |-- ')

fs.append({ 'l': root, 'i': -1 })
walk(root, 0, '|-- ')


def to_s(l):
  return ' '.join(filter(None, l))


for f in fs:
  if f['i'] < 0 or f['s'] == '-1':
    print(f['l'])
  else:
    ap = os.path.abspath(f['p'])
    g = git.get(ap)
    ls = f['L'] + 'L' if f['L'] else None
    if g:
      un = g.get('s')
      ad = '+' + g.get('a', '0') + '-' + g.get('d', '0')
      if un == '??':
        ad = 'untracked'
      elif un and un[0:1] == 'A':
        if ad == '+---':
          ad = 'new'
        else:
          ad = ad + ' new'
      print(to_s([ f['l'], f['s'], ls, ad ]))
    else:
      print(to_s([ f['l'], f['s'], ls ]))

