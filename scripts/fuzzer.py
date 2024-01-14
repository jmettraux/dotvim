# -*- coding: UTF-8 -*-

# fuzzer.py

import os, re, sys, glob, time, string, fnmatch, subprocess

W = int(sys.argv[1])

max_vimfuzz_lines = 21

pat = ''
opts = {}
keyr = re.compile('^([^:]+):(.+)$')
  #
try:
  lines = None
  with open('.vimfuzz2', 'r') as file:
    lines = file.readlines()
    pat = lines[-1].strip()
  with open('.vimfuzz2', 'w') as file:
    ls = []
    for l in lines:
      m = keyr.match(l)
      if m:
        file.write(l)
        opts[m.group(1)] = m.group(2)
      else:
        ls.append(l)
    while len(ls) > max_vimfuzz_lines:
      ls.pop(0)
    for l in ls:
      file.write(l)
except:
  ''
  #
patr = re.compile(pat, re.IGNORECASE);

exts = re.split(
  r"\s+",
  '''
    js rb ru java pl py c go
    sh fish vim
    txt text md mdown markdown
    htm html slim haml
    css scss
    xml toml json yaml yml conf cnf
    flo '''.strip())

#sortr = re.compile('^tmp')
#def sortPaths(path):
#  if sortr.search(path): return 'ZZZ/' + path
#  return path

files = filter(
  lambda p: os.path.splitext(p)[1][1:] in exts,
  glob.glob('**/*', recursive=True))
dirs = glob.glob(
  '**/*/', recursive=True)
paths = list(files) + dirs

for ign in opts.get('ignore', '').split(r'\s+'):
  paths = filter(lambda p: not(fnmatch.fnmatch(p, ign)), paths)

paths = filter(lambda p: patr.search(p), paths)
#paths = sorted(paths, key=sortPaths)
#paths = sorted(paths)

#
# file details

def exec_to_lines(cmd):
  return map(
    lambda l: l.decode().rstrip(),
    subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).stdout)

git = {}
  #
for line in exec_to_lines("git diff --numstat"):
  ll = line.split("\t")
  git[ll.pop()] = ll
for line in exec_to_lines("git diff --cached --numstat"):
  ll = line.split("\t")
  git[ll.pop()] = ll
#gits = exec_to_lines("git ls-files")
  # FIXME git root might not be here...

def d_size(path):
  size = os.path.getsize(path)
  step_unit = 1024.0 # https://stackoverflow.com/questions/12523586
  for x in [ 'B', 'K', 'M', 'G', 'T', 'P' ]:
    if size < step_unit: return "%i%s" % (size, x)
    size /= step_unit

def d_lines(path):
  l = 0
  try:
    with open(path, 'r') as file:
      for line in file: l += 1
  except:
    l = -1
  return l

def d_diff(path):
  g = git.get(path)
  return f"+{g[0]}-{g[1]}" if g else ''

def d_mtime(path):
  return os.path.getmtime(path)

#def d_git(path):
#  return path in gits

def d_age(mtime):
  i = int(time.time() - mtime)
  if i < 60: return '%is' % i
  d = int(i / (24 * 3600)); i = i % (24 * 3600)
  h = int(i / 3600); i = i % 3600
  m = int(i / 60); i = i % 60
  r = ''
  if d > 0: r = '%s%id' % (r, d)
  if d < 7 and h > 0: r = '%s%ih' % (r, h)
  if d < 1 and m > 0: r = '%s%im' % (r, m)
  return r

details = {}
  #
def detail(path):
  d = details.get(path)
  if d:
    return d
  mt = d_mtime(path)
  age = d_age(mt)
  if os.path.isdir(path):
    dl = len(path) - 1
    d = { "dir": True, "mtime": mt, "age": age, "dirl": dl }
  else:
    dl = len(os.path.dirname(path))
    if os.path.basename(path) == path: dl = dl - 1
    d = {
      "size": d_size(path), "lines": d_lines(path), "diff": d_diff(path),
      "mtime": mt, "age": age, "dirl": dl }
  details[path] = d
  return d

def sortPaths(path):
  d = detail(path)
  return - d['mtime']

paths = sorted(paths)
#paths = sorted(paths, key=sortPaths)

mdl = 0
for path in paths:
  d = detail(path)
  mdl = max(mdl, d['dirl'])

#
# output

endr = re.compile('^(.+)[-+0-9 ]$')
def endstrip(s):
  s = s[:W-1].rstrip()
  while True:
    m = endr.match(s)
    if not(m): break
    s = m.group(1)
  return s

print(pat)
  #
for path in paths:
  d = detail(path)
  offset = ' ' * (mdl - d['dirl'])
  if d.get('dir'):
    print(endstrip(
      ' %s%s' % (
        offset, path)))
  else:
    print(endstrip(
      ' %s%s %s %iL %s%s' % (
        offset, path, d['size'], d['lines'], d['diff'], d['age'])))
print()

  # keep that in the fridge, but most of the time, the fuzzer is
  # called from a .git level
  #
## determine git root
#
#gitroot = False
#try:
#  DEV_NULL = open(os.devnull, 'w')
#  gitroot = subprocess\
#    .check_output([ 'git', 'rev-parse', '--show-toplevel' ], stderr=DEV_NULL)\
#    .decode()\
#    .strip()
#except:
#  True # not a git repo

