
#
# scripts/_common.py

import os, time, subprocess


def compute_mtime_age(path):

  try:
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

  except Exception as e:
    return 'err'


def compute_size(path):

  size = os.path.getsize(path)
  step_unit = 1024.0 # https://stackoverflow.com/questions/12523586

  for x in [ 'B', 'K', 'M', 'G', 'T', 'P' ]:
    if size < step_unit: return "%i%s" % (size, x)
    size /= step_unit


#def compute_line_count(path):
#  l = 0
#  try:
#    with open(path, 'r') as file:
#      for line in file: l += 1
#  except:
#    l = -1
#  return f"{l}L"

def compute_line_count(path):

  try:
    return exec_to_line(f"wc -l {path}").split(' ')[0].strip() + 'L'
  except:
    return '-1L'


def exec_to_lines(cmd):

  return map(
    lambda l: l.decode().rstrip(),
    subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).stdout)

def exec_to_line(cmd):

  return subprocess.Popen(
    cmd, shell=True, stdout=subprocess.PIPE
      ).stdout.read().decode().strip()


def compute_git_diff():

  git = {}

  for line in exec_to_lines("git ls-files"):
    git[line] = [ 0, 0 ]
  for line in exec_to_lines("git diff --numstat"):
    ll = line.split("\t")
    git[ll.pop()] = ll
  for line in exec_to_lines("git diff --cached --numstat"):
    ll = line.split("\t")
    git[ll.pop()] = ll
  #gits = exec_to_lines("git ls-files")
    # FIXME git root might not be here...

  return git


def compute_git(git_diff, path):

  g = git_diff.get(path)

  return f" +{g[0]}-{g[1]}" if g else ''

