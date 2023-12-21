
#
# .vim/scripts/zapicat-index.py

import os, re, sys, glob
#import os, re, sys, glob, json, hashlib

#conf = 

#def shadig(x):
#  return hashlib.sha256(json.dumps(x).encode()).hexdigest()
def readlines(path):
  return open(path, 'r').readlines()

idx = { 'lines': {}, 'entries': [] }
  # TODO reload .zapicat.index

JS_MOD_REX = re.compile(r'\b(class)\s+([a-zA-Z0-9_]+)')
JS_MOJ_REX = re.compile(r'\b\s*var\s+([a-zA-Z0-9_]+)\s*=\s*\(function\(\)\s*\{')
JS_DEF_REX = re.compile(r'\bthis\.([a-zA-Z0-9_]+)\s*=[^=]')
JS_D3F_REX = re.compile(r'\bvar\s+([a-zA-Z0-9_]+)\s*=\s*function\(')
  #
def index_js_line(idx, path, line, l):
  p = path + ':' + str(l)
  m = re.search(JS_MOD_REX, line)
  if m:
    idx['lines'][p] = line.rstrip()
    idx['entries'].append({
      'l': 'js', 'p': p,  't': 'mod', 'k': m.group(2), 'tt': m.group(1) })
  m = re.search(JS_MOJ_REX, line)
  if m:
    idx['lines'][p] = line.rstrip()
    idx['entries'].append({
      'l': 'js', 'p': p,  't': 'mod', 'k': m.group(1), 'tt': 'j' })
  m = re.search(JS_DEF_REX, line)
  if m:
    idx['lines'][p] = line.rstrip()
    idx['entries'].append({
      'l': 'js', 'p': p,  't': 'def', 'k': m.group(1), 'tt': '-' })
  m = re.search(JS_D3F_REX, line)
  if m:
    idx['lines'][p] = line.rstrip()
    idx['entries'].append({
      'l': 'js', 'p': p,  't': 'def', 'k': m.group(1), 'tt': 'p' })

def index_js(idx, path):
  l = 0
  for line in readlines(path):
    l = l + 1
    index_js_line(idx, path, line, l)

RB_DEF_REX = re.compile(r'\bdef\s+([a-zA-Z0-9.:]+)')
RB_MOD_REX = re.compile(r'\b(module|class)\s*([a-zA-Z0-9.:]+)')
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
  { 'rex': '\.rb$', 'fun': index_rb },
  { 'rex': '\.js$', 'fun': index_js },
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

#
# index

for p in paths: index(idx, p)

#
# output

for e in idx['entries']:
  print(e['p'], e['t'], e['tt'], e['l'], e['k'])
for l in idx['lines']:
  print(l, '>', idx['lines'][l])

