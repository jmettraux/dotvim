# -*- coding: UTF-8 -*-

# grep.py

import os, re, sys, subprocess

maxlen = 7


regex = sys.argv[1]
directory = sys.argv[2]
uname = sys.argv[3]


cmd = 'grep -R -n'
if uname != 'OpenBSD':
  cmd += ' --exclude-dir=.git'
  cmd += ' --exclude-dir=tmp'
  cmd += ' --exclude=.viminfo'
cmd += ' ' + regex
cmd += ' ' + directory
#print cmd


#
# .vimgrep management

if os.path.isdir(directory) and not(re.search(r'/$', directory)):
  directory = directory + os.sep

ls = []
ls.append([ regex, directory ])

try:

  for l in open('.vimgrep', 'r').readlines():
    if len(ls) > maxlen:
      break
    m = re.match(r'^  / ("[^"]+"|\'[^\']+\') *(.+)$', l)
    if m:
      p = [ m.group(1), m.group(2) ]
      if not(p in ls):
        ls.append(p)
    #else:
    #  print '>>>' + l

except:

  pass

m = 0
for l in ls:
  m = max(len(l[0]), m)

try :

  f = open('.vimgrep', 'w')
  for l in ls:
    f.write('  / ' + l[0].ljust(m) + ' ' + l[1] + '\n')
  f.close

except:

  pass


#
# output for grep.vim

  # cmd += ' --exclude-dir=.git'
  # cmd += ' --exclude-dir=tmp'
  # cmd += ' --exclude=.viminfo'
  #
def should_mute(path):
  if re.search(r'(\.swp) matches$', path):
    return True
  ps = re.split(r'[\\\/]', path)
  return ps[0] == '.git' or ps[0] == 'tmp' or ps[-1] == '.viminfo'

path = None
mute = False

print()

for line in subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).stdout:
  line = line.decode('UTF-8', 'ignore')
  m = re.match(r'^([^:]+):(\d+):(.+)$', line)
  if not(m):
    m = re.match(r'^Binary file ([^$]+)$', line)
    if m:
      if should_mute(os.path.relpath(m.group(1))):
        line = False
    if line:
      print('grep.py choked on >>' + line.strip() + '<<')
  else:
    pa = os.path.relpath(m.group(1))
    nomute = not(should_mute(pa))
    if pa != path:
      if nomute:
        print(pa)
      path = pa
    if nomute:
      print('%5d|%s' % (int(m.group(2)), m.group(3)))

print()

