
# scan.py

import re, sys

fn = sys.argv[1]
f = open(fn, 'r')
ls = [ [ i + 1, l.rstrip() ] for i, l in enumerate(f.readlines()) ]
f.close

rs = [ r'.*' ]
c_rex = r'^\s*(#|//)'

if re.search(r'_spec\.rb$', fn):
  rs = [
    r'^require\s*(\s|\().',
    r'^\s*(describe|context|it)\s*(\s|\().',
    r'^\s*(before|after|around)\s*(\s|\():[a-z]',
      ]
elif re.search(r'_test\.rb$', fn):
  rs = [
    r'^require\s*(\s|\().',
    r'^\s*(group|test|section)\s+',
    r'^\s*(setup|teardown|before|after)\s+',
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
    r'^\s*this\.[a-z][a-zA-Z0-9_]+\s*=\s*',
    #r'^\s*this\..+\s*=\s*.+\bfunction\b',
    r'^\s*var\s+[A-Z]',
    r'^\s*function\s+',
    r'^\s*class\s+',
    r'^\s*constructor\(',
    r'^\s*#[a-z_][a-z_A-Z0-9]+',
    r'^\s*[a-z_][a-z_A-Z0-9]+\([^(){]*\)\s*{\s*$',
    r'^\s*(get|set)\s+[a-z_][a-z_A-Z0-9]+',
      ]
  c_rex = r'^\s*//'
elif re.search(r'\.md$', fn):
  rs = [
    r'#',
      ]
  c_rex = r'^\s*<!--'
elif re.search(r'\.scad$', fn):
  rs = [
    r'^[^\s]+ = ',
    r'^\s*(function|module)\s+',
      ]
elif re.search(r'\.s?css$', fn):
  rs = [
    r'^[^/]+\s*{',
      ]

rs.append(r'\bTODO\b')
rs.append(r'\bFIXME\b')

#print "<<<"
#print fn
#print rs
#print "<<<"

p_line = None
c_lines = []
  #
  # comments displaying


for i, l in ls:

  #
  # is it a full comment line?

  c_m = re.search(c_rex, l)

  if len(c_lines) == 0 and c_m:
    c_lines.append([ -1, p_line ])
    p_line = None
  if c_m:
    c_lines.append([ i, l ])
    continue

  cl = len(c_lines)
  c1 = ''
  c0 = ''
  if cl > 2:
    c1 = c_lines[0][1]
    c0 = c_lines[1][1]
    if c0: c0 = c0.strip()
    if c1: c1 = c1.strip()

  if cl >= 2 and c1 == '' and (c0 == '//' or c0 == '#'):
    for ii, ll in c_lines[1:]:
      if len(ll) > 70:
        ll = ll[0:70] + '...'
      print('%5d %s' % (ii, ll))

  c_lines = []

  #
  # regular, code line

  p_line = l

  for r in rs:
    if re.search(r, l):
      print('%5d %s' % (i, l))
      break

