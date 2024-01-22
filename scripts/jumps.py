# -*- coding: UTF-8 -*-

#
# scripts/jumps.py

#import os, re, sys, time, string, subprocess
import re, sys

W = int(sys.argv[1])

jumps = []
files = {}


def add_file(path):

  # TODO only load "text" files...

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

# TODO sort by "path:line"
  #
#sortr = re.compile('^tmp')
#def sortPaths(path):
#  if sortr.search(path): return 'ZZZ/' + path
#  return path
#paths = sorted(paths, key=sortPaths)

print()

for j in jumps:
  f = files.get(j['path'])
  l = f and f[j['line'] - 1]
  if not l: continue
  s = f' %{lmax}s:%-3d %-2d %s' % (j['path'], j['line'], j['col'], l)
  s = s.rstrip()
  if len(s) > W: s = s[:W-1] + '‣'
  print(s)

print()

