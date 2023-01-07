# -*- coding: UTF-8 -*-

# scripts/diff.py

import os, re, sys, subprocess

from_path = sys.argv[1]
to_path = sys.argv[2]


def split_line_numbers(s):
  ss = s.split(',')
  if len(ss) < 2: ss.append(ss[0])
  return [ int(si) - 1 for si in ss ]


#
# determine "comment string"

comment = '//'
  # TODO adapt to .js, .vim, .sql, etc...


#
# read version 0

from_lines = None
  #
with open(from_path) as f:
  from_lines = [ l.rstrip() for l in f ]


#
# read diff

cmd = 'diff ' + from_path + ' ' + to_path

diffs = []
diff = None
dlines = None
  #
for line in subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).stdout:

  line = line.decode().rstrip()
  m = re.match(r'^(\d+(,\d+)?)([acd])(\d+(,\d+)?)$', line)

  if m:
    dlines = []
    diff = [
      m.group(3),
      split_line_numbers(m.group(1)),
      split_line_numbers(m.group(4)),
      dlines ]
    diffs.append(diff)
  else:
    dlines.append(line)


#
# render...

dli1 = None
  #
for i in range(len(from_lines)):
  d = len(diffs) > 0 and diffs[0]
  if d and i == d[1][0]:
    print(comment + ' ' + d[0] + ' ' + str(d[1]) + ' ' + str(d[2]))
    for dl in d[3]:
      #print(comment + dl[2 + len(comment):])
      if dl[0:1] == '<':
        print(comment + '<' + dl[0 + len(comment):]) # FIXME
      elif dl == '---':
        1 # noop
      else:
        print(dl[2:])
    diffs = diffs[1:]
    continue
  if d and i > d[1][0] and i <= d[1][1]:
    print(comment + '>')
    continue
  print(from_lines[i])

