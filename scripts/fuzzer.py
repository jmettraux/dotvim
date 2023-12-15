# -*- coding: UTF-8 -*-

# fuzzer.py

import os, re, sys, string, subprocess, glob


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

#
# file details

#  # 15      11      app/views/wma/_dac_4_approvals.slim
#  # 67      24      app/views/wma/_dac_5_assignment.slim
#  # 1       1       app/views/wma/_dac_mandates.slim
#  #
#$git = `git diff --numstat`.strip.split("\n")
#  .inject({}) { |h, l|
#    ll = l.split("\t")
#    h[ll.pop] = ll
#    h }
#      # FIXME git root might not be here...
#$gits = `git ls-files`.strip.split("\n")

#def d_size(path)
#  i = File.size(path)
#  [ '', 'K', 'M', 'G', 'T' ].each do |n|
#    return "#{i.to_i}#{n}" if i < 1024
#    i = i / 1024.0
#  end
#  '-1'
#end
#def d_lines(path)
#  "#{(File.readlines(path).size rescue -1)}l"
#end
#def d_diff(path)
#  g = $git[path]
#  g ? "+#{g[0]}-#{g[1]}" : nil
#end
#def d_recent(path)
#  (Time.now - File.mtime(path)) < 24 * 60 * 60
#end
#def d_git(path)
#  $gits.include?(path)
#end
#  #
#def detail(path)
#  $details ||= {}
#  $details[path] ||=
#    File.directory?(path) ?
#    { dir: true, recent: d_recent(path), git: true } :
#    { size: d_size(path), lines: d_lines(path), diff: d_diff(path),
#      recent: d_recent(path), git: d_git(path) }
#end

#
# output

print(pat)
  #
for file in files:
  print('  ' + file)

#if os.path.isfile(root): root = os.path.dirname(root)
#if root[-1] != '/': root = root + '/'
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

