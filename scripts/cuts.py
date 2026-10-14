
import os, sys, re
import _common

#
# scripts/cuts.py

pathr = re.compile('^[ 	]*([^# 	]+)')

git_diff = _common.compute_git_diff()

path = sys.stdin.read().strip()

def print_path(path):
  siz = _common.compute_size(path)
  lic = _common.compute_line_count(path)
  age = _common.compute_mtime_age(path)
  git = _common.compute_git(git_diff, path)
  print(f"{path} {siz} {lic} {age}{git}")

with open(path, 'r') as file:
  for line in file.readlines():
    line = line.strip()
    m = pathr.match(line)
    if m:
      print_path(m.group(1))
    else:
      print(line)

