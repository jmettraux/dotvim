
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
    r'^if \$0 == __FILE__',
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

c_rex = r'^\s*(#|//)'
c_threshold = 3
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

  cl = len(c_lines)
  c0 = ''
  if cl > 1:
    c0 = c_lines[0][1].strip()

  #if cl >= c_threshold or (cl >= 2 and (c0 == '//' or c0 == '#')):
  #  for ii, ll in c_lines:
  #    if len(ll) > 70:
  #      ll = ll[0:70] + '...'
  #    print '%5d %s' % (ii, ll)

  c_lines = []

  #
  # regular, code line

  for r in rs:
    if re.search(r, l):
      print '%5d %s' % (i, l)
      break

