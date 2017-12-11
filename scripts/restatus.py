
import re, subprocess

lines = \
  subprocess.check_output("git status", shell=True).splitlines() + \
  subprocess.check_output("git diff --stat", shell=True).splitlines()

paths = {}
footer = []

for line in lines:
  m = re.match('\A\s+new file:\s+(.+)', line)
  if m:
    paths[m.group(1)] = m.group(1) + "  (new file)"
    continue
  m = re.match('\A\s+modified:\s+(.+)', line)
  if m:
    paths[m.group(1)] = m.group(1) + "  (modified)"
    continue
  m = re.match('\A\s+deleted:\s+(.+)', line)
  if m:
    paths[m.group(1)] = m.group(1) + "  (deleted)"
    continue
  m = re.match('\A ([^\(]+)\s+\|[ ]*(\d+) (\+[-+]*)', line)
  if m:
    paths[m.group(1)] = m.group(1) + " | " + m.group(3) + " " + m.group(2)
    continue
  m = re.match('\A\s\d+ ', line)
  if m:
    footer.append("#\n#" + line)
    #continue
  #print '>>>' + line

for line in sorted(paths.values()):
  print line
for line in footer:
  print line

