# -*- coding: UTF-8 -*-

# opengitdiff.py

import sys, re, subprocess

lines = subprocess\
  .Popen(
    'git diff -U9999999 --no-color ' + sys.argv[1],
    shell=True,
    stdout=subprocess.PIPE)\
  .stdout\
  .readlines()

digits = str(len(str(len(lines))))

lnum = -1

for line in lines:

  line = line.rstrip('\r\n')

  if lnum > -1:
    if re.match(r'^[^-]', line): lnum = lnum + 1
    print(('%' + digits + 'i %s') % (lnum, line))
  else:
    print(line)
    m = re.match(r'^@@ [-+0-9, ]+ @@$', line)
    if m:
      lnum = 0
      print()

print()

