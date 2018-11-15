
import os, re, subprocess


lines = \
  subprocess.check_output("git status", shell=True).splitlines()
lines = lines + \
  subprocess.check_output("git diff --stat", shell=True).splitlines()[:-1]

def stat_dir(path):
  if os.path.isdir(path):
    ls = subprocess \
      .check_output("git diff --stat " + path + " | tail -1", shell=True) \
      .splitlines()
    if len(ls) > 0:
      return [ ls[0] + ", " + path ]
  return []

for path in [ 'lib/', 'src/', 'scripts/', 'app/', 'spec/', 'test/', './' ]:
  lines = lines + stat_dir(path)


paths = {}
stats = []

for line in lines:
  m = re.match('\A\s+new file:\s+(.+)', line)
  if m:
    paths[m.group(1)] = [ m.group(1), "| (new file)" ]
    continue
  m = re.match('\A\s+modified:\s+(.+)', line)
  if m:
    paths[m.group(1)] = [ m.group(1), "| (modified)" ]
    continue
  m = re.match('\A\s+deleted:\s+(.+)', line)
  if m:
    paths[m.group(1)] = [m.group(1), "| (deleted)" ]
    continue
  m = re.match('\A ([^\(]+)\s+\|[ ]*(\d+) ([-+]\+*-*)', line)
  if m:
    paths[m.group(1).strip()] = [ m.group(1), "| " + m.group(3) + " " + m.group(2) ]
    continue
  m = re.match('\A\s\d+ ', line)
  if m:
    stats.append(line)
    #continue
  m = re.match('\A\s+renamed:\s+(.+) -> (.+)', line)
  if m:
    paths[m.group(2)] = [ m.group(2), '| (renamed)' ]
    continue

#
# print paths

ps = paths.values()
m = 0
for p in ps:
  m = max(len(p[0]), m)
m = m + 1
ps = map(lambda p: p[0].ljust(m) + p[1], ps)

for p in sorted(ps):
  print p


#
# print stats

maxes = [ 1, 1, 1, 1 ]
counts = []

for l in stats:
  m = re.match("^\s*(\d+) ([^,]+)(?:, (\d+) ([^,]+))(?:, (\d+) ([^,]+))?, (.+)$", l)
  #print m.groups()
  pa = m.group(7)
  fc = m.group(1)
  ic = '0'
  dc = '0'
  if m.group(4) and re.match('ins', m.group(4)):
    ic = m.group(3)
  if m.group(6) and re.match('del', m.group(6)):
    dc = m.group(5)
  maxes[0] = max(maxes[0], len(pa))
  maxes[1] = max(maxes[1], len(fc))
  maxes[2] = max(maxes[2], len(ic))
  maxes[3] = max(maxes[3], len(dc))
  counts.append([ m.group(7), fc, ic, dc ])

if len(counts) > 0:
  print '#'

if len(counts) == 2:
  counts = counts[:-1]

def f(mo):
  return str(maxes[int(mo.group(1))])
for c in counts:
  if c[0] == './':
    print '#'
  print re.sub("m(\d)", f, "# %-m0s  files changed: %m1s, insertions: %m2s, deletions: %m3s") % (c[0], c[1], c[2], c[3]) # :-(

