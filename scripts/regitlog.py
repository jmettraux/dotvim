
import sys, re


for line in sys.stdin:

  l = line.rstrip()

  m = re.match(r'^([*|\\/ ]+)([^\s]+)([^|]+)\|([^ ]+)(.*)$', l)

  if m:

    head = m.group(1).rstrip() + ' ' + m.group(2)

    author = re.sub(r'[^A-Z]', '', m.group(3).strip())
    if len(author) < 1:
      author = m.group(3).strip()[:3]

    date = m.group(4)[:16]
    date = re.sub(r'[-:]', '', date)
    date = re.sub(r'[T]', ' ', date)

    text = m.group(5).lstrip()

    print ' '.join((head, author, date, text))

  else:

    print l

