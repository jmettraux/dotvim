
import os, re, subprocess


lines = subprocess.check_output("git status", shell=True).splitlines()

def stat_dir(path):
  if os.path.isdir(path):
    return [
      subprocess.check_output("git diff --stat " + path + " | tail -1", shell=True).splitlines()[0] + " (" + path + ")" ]
  else:
    return []

for path in [ 'lib/', 'src/', 'spec/', 'test/' ]:
  lines = lines + stat_dir(path)

lines = lines + subprocess.check_output("git diff --stat", shell=True).splitlines()


paths = {}
footer = [ '#' ]

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
  m = re.match('\A ([^\(]+)\s+\|[ ]*(\d+) (\+[-+]*)', line)
  if m:
    paths[m.group(1).strip()] = [ m.group(1), "| " + m.group(3) + " " + m.group(2) ]
    continue
  m = re.match('\A\s\d+ ', line)
  if m:
    footer.append("#" + line)
    #continue
  m = re.match('\A\s+renamed:\s+(.+) -> (.+)', line)
  if m:
    paths[m.group(2)] = [ m.group(2), '| (renamed)' ]
    continue

footer.insert(len(footer) - 1, '#')

ps = paths.values()
m = 0
for p in ps:
  m = max(len(p[0]), m)
m = m + 2
ps = map(lambda p: p[0].ljust(m) + p[1], ps)

for p in sorted(ps):
  print p

for l in footer:
  print l

