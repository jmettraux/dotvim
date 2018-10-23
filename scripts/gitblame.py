# -*- coding: UTF-8 -*-

# gitblame.py

import os, re, sys, subprocess

path = sys.argv[1]

cmd = 'git blame ' + path

previous_head = ''
title_shown = False

for line in subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).stdout:

  m = re.match(r'^([a-fA-F0-9]+) ([^(]+)?\((.+) (\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}) ([-+]\d{4}) (\s*\d+)\) (.+)?$', line)

  sha = m.group(1)
  author = m.group(3)[:3]
  date = m.group(4)
  lnum = m.group(6)
  line = m.group(7) or ''

  date = re.sub(r'[-: ]', '', date)
  date = date[:12]

  head = sha + ' ' + author + ' ' + date

  if head == previous_head:
    lh = len(head)
    if title_shown == False:
      title_shown = True
      head = '  ' + os.popen('git show -s --format="%s" ' + sha).read()
    else:
      head = ''
    head = ('%-' + str(lh) + 's') % head[:lh]
  else:
    previous_head = head
    title_shown = False

  print head + ' ' + lnum + (' ' + line if len(line) > 0 else '')

