
import re
import sys

out = [
  'COMMIT_EDITMSG', 'NetrwTreeListing', 'bash-fc-', '==[A-Z]',
  '\/private\/var\/', '\/mutt-' ]

paths = []

for line in sys.stdin:
  m = re.match('\d+: ([^ \n]+)', line)
  if not m:
    continue
  if next((r for r in out if re.search(r, line)), None):
    continue
  paths.append(m.group(1))


print "== recent"

for path in paths:
  print path

