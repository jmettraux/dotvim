# -*- coding: UTF-8 -*-

# opengitdiff.py

import sys, re, subprocess

path = sys.argv[1]

cmd = 'git diff -U9999999 --no-color ' + path

lnum = -1

for line in subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).stdout:

  #print line.rstrip()

  if lnum > -1:
    if re.match(r'^[^-]', line): lnum = lnum + 1
    print '%5i %s' % (lnum, line.rstrip())
  else:
    print line.rstrip()
    m = re.match(r'^@@ [-+0-9, ]+ @@\n', line)
    if m:
      lnum = 0
      print

print

