# -*- coding: UTF-8 -*-

# fuzzer.py

import os, re, sys, glob, time, string, subprocess


pat = ''
  #
try:
  with open('.vimfuzz2', 'r') as file:
    lines = file.readlines()
    pat = lines[-1].strip()
except:
  ''

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

files = glob.glob('**/*', recursive=True)
files = filter(lambda p: os.path.splitext(p)[1][1:] in exts, files)
files = filter(lambda p: pat in p, files)
  # TODO downcase...

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

def d_recent(path):
  return (time.time() - os.path.getmtime(path)) < 24 * 60 * 60

#def d_git(path):
#  return path in gits

details = {}
  #
def detail(path):
  d = details.get(path)
  if d:
    return d
  if os.path.isdir(path):
    #d = { "dir": True, "recent": d_recent(path), "git": True }
    d = { "dir": True, "recent": d_recent(path) }
  else:
    d = {
      "size": d_size(path), "lines": d_lines(path), "diff": d_diff(path),
      "recent": d_recent(path) }
      #"recent": d_recent(path), "git": d_git(path) }
  details[path] = d
  return d

#
# output

print(pat)
  #
for file in files:
  #print('  ' + file + ' ' + str(detail(file)))
  d = detail(file)
  print(('  %s %s %iL %s' % (file, d['size'], d['lines'], d['diff'])).rstrip())


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

