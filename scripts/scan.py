
# scan.py

import re, sys

f = open(sys.argv[1], 'r')
ls = map(lambda l: l.rstrip(), f.readlines())
f.close

r = [
  'module', 'class', 'def', 'alias', 'attr_(reader|accessor|writer)', 'function',
  'public', 'private', 'protected', 'Option', 'Public', 'Sub', 'Function',
  'before', 'after', 'describe', 'context', 'it',
  'TODO', 'FIXME' ]
r = r'\A\s*\b(' + '|'.join(r) + r')\b'
print r

ls = [ l for l in ls if re.match(r, l) ]

for l in ls:
  print l

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

