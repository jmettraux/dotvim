# -*- coding: UTF-8 -*-

# tree.py

import os, re, sys, string, subprocess


# determine root

root = sys.argv[1]
if root[-1] != '/': root = root + '/'

# determine git root

gitroot = subprocess.check_output([ 'git', 'rev-parse', '--show-toplevel' ]).strip()

# gather git stats

git = {}

cmd = 'git diff --numstat'
for line in subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).stdout:
  line = line.strip()
  #print [ 'gdns', line ]
  ss = string.split(line)
  ap = os.path.abspath(os.path.join(gitroot, ss[2]))
  git[ap] = { 'p': ss[2], 'a': ss[0], 'd': ss[1] }

cmd = 'git status -s'
for line in subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).stdout:
  line = line.strip()
  #print [ 'gss', line ]
  ss = string.split(line)
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

#print git
#print git.keys()
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
  line = line.strip()
  ss = string.split(line)
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

cmd = 'tree -F ' + root

for line in subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).stdout:

  line = line.rstrip()

  d = { 'l': line, 'i': -1 }
  fs.append(d);

  m = re.match(r'^([-|` ]+ )?(.*)$', line)
  if m == None: continue
  d['i'] = len(m.group(1) or '')
  d['n'] = m.group(2)
  d['p'] = compute_path()
  d['s'] = compute_size(d['p'])
  d['d'] = os.path.isdir(d['p'])
  d['L'] = wcl.get(os.path.abspath(d['p']))

def to_s(l):
  return ' '.join(filter(None, l))


for f in fs:
  if f['i'] < 0 or f['s'] == '-1':
    print f['l']
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
        ad = ad + ' new'
      print to_s([ f['l'], f['s'], ls, ad ])
    else:
      print to_s([ f['l'], f['s'], ls ])

