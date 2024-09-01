
#
# scripts/_common.py

import os, time


def compute_mtime_age(path):

  i = int(time.time() - os.path.getmtime(path))

  if i < 60: return '%is' % i
  d = int(i / (24 * 3600)); i = i % (24 * 3600)
  h = int(i / 3600); i = i % 3600
  m = int(i / 60); i = i % 60

  r = ''
  if d > 0: r = '%s%id' % (r, d)
  if d < 7 and h > 0: r = '%s%ih' % (r, h)
  if d < 1 and m > 0: r = '%s%im' % (r, m)

  return r

