
#
# .vim/scripts/zapicat-index.py

import os, re, sys, glob, json, hashlib

#conf = 

def shadig(x):
  return hashlib.sha256(json.dumps(x).encode()).hexdigest()
def readlines(path):
  return open(path, 'r').readlines()

idx = { 'lines': {}, 'entries': [] }
  # TODO reload .zapicat.index

RB_DEF_REX = re.compile(r'\bdef\s+([^\s(;]+)')
RB_MOD_REX = re.compile(r'\b(module|class)\s*([^\s;{}]+)')
#RB_ASS_REX = re.compile(r'\b([^=]+)\s*=\s*[^=>]')
  #
def index_rb_line(idx, path, line, l):
  p = path + ':' + str(l)
  m = re.search(RB_DEF_REX, line)
  if m:
    idx['lines'][p] = line.rstrip()
    idx['entries'].append({
      'l': 'ruby', 'p': p,  't': 'fun', 'k': m.group(1), 'tt': '-' })
  m = re.search(RB_MOD_REX, line)
  if m:
    idx['lines'][p] = line.rstrip()
    idx['entries'].append({
      'l': 'ruby', 'p': p,  't': 'mod', 'k': m.group(2), 'tt': m.group(1) })

def index_rb(idx, path):
  l = 0
  for line in readlines(path):
    l = l + 1
    index_rb_line(idx, path, line, l)

indexers = [
  { 'rex': '\.rb$', 'fun': index_rb }
    ]

def post_index(idx, index):
  return index

def index(idx, path):
  for indexer in indexers:
    rex = indexer.get('rex')
    nam = indexer.get('name')
    pat = indexer.get('path')
    if (
      (rex and re.search(rex, path)) or
      (nam and nam == os.path.basename(path)) or
      (pat and path.ends_with(pat))
    ): return post_index(idx, indexer['fun'](idx, path))
  return {}

glo = sys.argv[1] if len(sys.argv) > 1 else '**/*'
paths = glob.glob(glo, recursive=True)

for p in paths: index(idx, p)

#for i in idx:
#  #print(json.dumps(i))
#  print(i['p'] + ':' + str(i['i']), i['t'], i['tt'], i['k'], '>', i['l'])
for e in idx['entries']:
  print(e['p'], e['t'], e['tt'], e['l'], e['k'])
for l in idx['lines']:
  print(l, '>', idx['lines'][l])

