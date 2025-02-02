
import sys, re, subprocess


def exec_to_lines(cmd):
  return map(
    lambda l: l.decode().rstrip(),
    subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).stdout)

#W = int(list(exec_to_lines('tput cols'))[0])
W = int(sys.argv[1])


for line in sys.stdin:

  l = line.rstrip()

  m = re.match(r'^([*|\\/ ]+)([^\s]+)([^|]+)\|([^ ]+)  (\([^)]+\))?(.*)$', l)

  if m:

    head = m.group(1).rstrip() + ' ' + m.group(2)

    author = re.sub(r'[^A-Z]', '', m.group(3).strip())
    if len(author) < 1:
      author = m.group(3).strip()
    author = author[:2].upper()

    date = m.group(4)[:16]
    date = re.sub(r'[-:]', '', date)
    date = re.sub(r'[T]', ' ', date)

    tags = m.group(5)

    text = m.group(6).lstrip()

    s = head + ' ' + author + ' ' + date + ' '
    if tags:
      s = s + re.sub(r' ', '', tags) + ' '
    s = s + text

    if len(s) > W: s = s[:W - 1] + '…'

    print(s)

  else:

    print(l)

