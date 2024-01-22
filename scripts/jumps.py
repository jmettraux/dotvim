# -*- coding: UTF-8 -*-

#
# scripts/jumps.py

import os, re, sys

W = int(sys.argv[1])

jumps = []
files = {}

exts = [ x for x in re.split(r'\s+', '''
    .js .rb .ru .flo .c
    .yaml .json
    .slim .html
    .css .scss
    .txt .log
  ''') if len(x) > 0 ]
#print(exts)


def add_file(path):

  if not(os.path.splitext(path)[1] in exts): return

  files[path] = \
    files.get(path) or \
    open(path, 'r').readlines()
    #[ l.strip() for l in open(path, 'r').readlines() ]


for line in sys.stdin:

  l = line.rstrip()

  if l == '>': continue

  ss = re.split(r'\s+', l)

  if len(ss) < 5: continue
  if ss[4] == '-invalid-': continue
  if ss[4] == '==ListFiles': continue
  if ss[4] == '.git/COMMIT_EDITMSG': continue
  if ss[1] == 'jump': continue

  if re.match(r'^_[a-zA-Z]__[_a-zA-Z0-9]+$', ss[4]): continue
  jumps.append({
    'jump': ss[1], 'line': int(ss[2]), 'col': int(ss[3]), 'path': ss[4] })
  add_file(ss[4])

lmax = 0
for j in jumps:
  lmax = max(lmax, len(j['path']))

def count_wspace(string):
  m = re.search(r'^\s+', string)
  return len(m.group()) if m else 0

lleft = 9999
for j in jumps:
  f = files.get(j['path'])
  t = f and f[j['line'] - 1]
  if t: lleft = min(lleft, count_wspace(t))
  j['text'] = t
jumps = [ j for j in jumps if j['text'] ]

jumps = sorted(
  jumps,
  key=lambda e: '%s:%3d' % (e["path"], e["line"]))

print()

for j in jumps:
  t = j['text'][lleft:]
  if len(t) > 0: t = ' ' + t
  s = f' %{lmax}s:%-3d %-2d%s' % (j['path'], j['line'], j['col'], t)
  s = s.rstrip()
  if len(s) > W: s = s[:W-1] + '‣'
  print(s)

print()

