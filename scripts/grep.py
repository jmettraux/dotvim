# -*- coding: UTF-8 -*-

# grep.py

import os, re, sys, subprocess


regex = sys.argv[1]
directory = sys.argv[2]


# TODO write to .vimgrep

cmd = 'grep -R -n'
cmd += ' --exclude-dir=.git'
cmd += ' --exclude-dir=tmp'
cmd += ' --exclude=.viminfo'
cmd += ' --exclude=*.swp'
cmd += ' ' + regex
cmd += ' ' + directory
#print cmd


#
# .vimgrep management

ls = []
try:
  ls = open('.vimgrep', 'r').readlines()
except:
  pass
ls.append(('  / ' + regex).ljust(35) + ' ' + directory + '\n')

f = open('.vimgrep', 'w')
count = 0
seen = []
for l in ls:
  if l in seen:
    continue
  f.write(l)
  seen.append(l)
  count = count + 1
  if count > 14:
    break
f.close


#
# output for grep.vim

path = None

print

for line in subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).stdout:
  m = re.match(r'^([^:]+):(\d+):(.+)$', line)
  if not(m):
    print 'grep.py choked on >>' + line.strip() + '<<'
  else:
    pa = os.path.relpath(m.group(1))
    if pa != path:
      print pa
      path = pa
    print '%5d|%s' % (int(m.group(2)), m.group(3))

print

