
#
# .vim/scripts/zapicat-browse.py

import os, re, sys, glob, json, pickle

CONF_FNAME = '.zapicat'
INDEX_FNAME = '.zapicat.index'


#def to_list(x):
#  return x if isinstance(x, list) else [ x ]

def read_lines(path):
  return open(path, 'r').readlines()

def read_conf():
  try: return json.load(open(CONF_FNAME, 'r'))
  except: 1
  return {}

conf = read_conf()

def read_index():
  try: return pickle.load(open(INDEX_FNAME, 'rb'))
  except: return { 'mtime': 0, 'files': {}, 'lines': {}, 'entries': [] }

#idx = { 'mtime': 0, 'files': {}, 'lines': {}, 'entries': [] }
idx = read_index()

argv = sys.argv[1:]
cat = None; key = None
if len(argv) > 1:
  cat = argv[0]; key = argv[1]
elif len(argv) > 0:
  key = argv[0]

for e in idx['entries']:
  if cat and e['t'] != cat: continue
  if key and key != e['k']: continue
  print(e)

