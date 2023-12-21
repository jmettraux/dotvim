
#
# .vim/scripts/zapicat-index.py

import os, re, sys, glob, pickle
#import os, re, sys, glob, json, hashlib

#conf = 

#def shadig(x):
#  return hashlib.sha256(json.dumps(x).encode()).hexdigest()
def read_lines(path):
  return open(path, 'r').readlines()

#LINE_REX = re.compile(r'^([^:]+):(\d+) > (.+)$')
#ENTRY_REX = re.compile(r'^([^:]+):(\d+) (.+)$')
#  #
#def read_index():
#  idx = { 'lines': {}, 'entries': [] }
#  try:
#    lines = read_lines('.zapicat')
#    paths = glob.glob('**/*', recursive=True)
#    for l in lines:
#      ml = re.match(LINE_REX, l)
#      me = not(ml) and re.match(ENTRY_REX, l)
#      m = ml or me
#      if not(m): continue
#      f = m.group(1)
#      if f not in paths: continue
#      p = f + ':' + m.group(2)
#      if ml:
#        idx['lines'][p] = m.group(3).rstrip()
#      elif me:
#        ss = m.group(3).rstrip().split(' ')
#        idx['entries'].append({
#          'p': p, 't': ss[0], 'tt': ss[1], 'l': ss[2], 'k': ss[3] })
#  except:
#    1
#  return idx

idx = { 'mtime': 0, 'lines': {}, 'entries': [] }
#idx = read_index()

JS_COM_REX = re.compile(r'^\s*\/\/')
JS_MOD_REX = re.compile(r'\b(class)\s+([a-zA-Z0-9_]+)')
JS_MOJ_REX = re.compile(r'\b\s*var\s+([a-zA-Z0-9_]+)\s*=\s*\(function\(\)\s*\{')
JS_DEF_REX = re.compile(r'\bthis\.([a-zA-Z0-9_]+)\s*=[^=]')
JS_D3F_REX = re.compile(r'\bvar\s+([a-zA-Z0-9_]+)\s*=\s*function\(')
JS_DCF_REX = re.compile(r'\b([#a-zA-Z0-9_]+)\s*\([^)]+\)\s*\{')
JS_DCF_NOT = [ 'if', 'function', 'forEach' ]
  #
def index_js_line(idx, path, line, l):
  if re.match(JS_COM_REX, line): return
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
  m = re.search(JS_DCF_REX, line)
  if m and (m.group(1) not in JS_DCF_NOT):
    idx['lines'][p] = line.rstrip()
    idx['entries'].append({
      'l': 'js', 'p': p,  't': 'def', 'k': m.group(1), 'tt': 'c' })

def index_js(idx, path):
  if path.endswith('.min.js'): return
  idx['mtime'] = max(os.path.getmtime(path), idx['mtime'])
  l = 0
  for line in read_lines(path):
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
  idx['mtime'] = max(os.path.getmtime(path), idx['mtime'])
  l = 0
  for line in read_lines(path):
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

if '--mtime' in sys.argv:
  with open('.zapicat', 'rb') as file:
    idx = pickle.load(file)
    print(idx.get('mtime'))
  exit(0)

glo = sys.argv[1] if len(sys.argv) > 1 else '**/*'
paths = glob.glob(glo, recursive=True)

#
# index

for p in paths: index(idx, p)

#
# output

#with open('.zapicat', 'w') as file:
#  json.dump(idx, file)
with open('.zapicat', 'wb') as file:
  pickle.dump(idx, file)

