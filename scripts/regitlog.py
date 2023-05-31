
import sys, re


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

    print(s)

  else:

    print(l)

