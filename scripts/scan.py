
# scan.py

import re, sys

fn = sys.argv[1]
f = open(fn, 'r')
ls = [ [ i + 1, l.rstrip() ] for i, l in enumerate(f.readlines()) ]
f.close

rs = [ r'.*' ]

if re.search(r'_spec\.rb$', fn):
  rs = [
    r'^require\s*(\s|\().',
    r'^\s*(describe|context|it)\s*(\s|\().',
    r'^\s*(before|after)\s*(\s|\():[a-z]',
      ]
elif re.search(r'\.rb$', fn):
  rs = [
    r'^require\s*(\s|\().',
    r'^\s*(module|class)\s+',
    r'^\s*attr_(accessor|reader|writer)\b',
    r'^\s*(public|protected|private)\b',
    r'^\s*def\s+',
    r'^\s*alias\b',
    r'^\s*(get|post|put|delete|head)\s+', # Sinatra
      ]
elif re.search(r'\.js$', fn):
  rs = [
    r'^\s*var\s+self\s*=',
    r'^\s*var\s+.+\s*=\s*\(?\s*function\s*\(',
    r'^\s*this\..+\s*=\s*',
    #r'^\s*this\..+\s*=\s*.+\bfunction\b',
    r'^\s*var\s+[A-Z]',
    r'^\s*function\s+',
      ]

rs.append(r'\bTODO\b')
rs.append(r'\bFIXME\b')

#print "<<<"
#print fn
#print rs
#print "<<<"

c_rex = r'^\s*(#|//).+'
c_threshold = 4
c_lines = []
  #
  # comments displaying


for i, l in ls:

  #
  # is it a full comment line?

  c_m = re.search(c_rex, l)

  if c_m:
    c_lines.append([ i, l ])
    continue

  if len(c_lines) >= c_threshold:
    for ii, ll in c_lines:
      print '%5d %s' % (ii, ll)

  c_lines = []

  #
  # regular, code line

  for r in rs:
    if re.search(r, l):
      print '%5d %s' % (i, l)
      break

