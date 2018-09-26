
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
    r'^\s*var\s+.+\s*=\s*\(?\s*function\s*\(',
    r'^\s*this\..+\s*=\s*',
      ]

rs.append(r'\bTODO\b')
rs.append(r'\bFIXME\b')

#print "<<<"
#print fn
#print rs
#print "<<<"

for i, l in ls:
  for r in rs:
    if re.search(r, l):
      print '%5d %s' % (i, l)

## scan.pl
#
#$i = 1;
#while (<>) {
#  if (
#    /^\s*
#      (
#        module\s+|
#        class\s+|
#        def\s+[^\s.]+|
#        alias\s+[^\s.]+\s+[^\s.]+|
#        attr_(reader|accessor|writer)\s+|
#        \bvar\s+.+\s+=\s+\(?function\b|
#        public\b|protected\b|private\b|
#        Option\b|Public\b|Sub\b|Function\b|
#        before\s+:[a-z]+|after\s+:[a-z]+|
#        describe\s+(['"A-Za-z])|context\s+['"]|it\s+['"]
#      )|
#      \s+this\.\S+\s+=\s+function\b
#    /x ||
#    /\bFIXME|TODO\b/
#  ) {
#    printf("%5d %s", $i, $_);
#  };
#  $i = $i + 1;
#}

