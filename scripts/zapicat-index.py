
#
# .vim/scripts/zapicat-index.py

import os, re, sys, glob, json, pickle, fnmatch

CONF_FNAME = '.zapicat'
INDEX_FNAME = '.zapicat.index'


def read_lines(path):
  return open(path, 'r').readlines()

def read_conf():
  try: return json.load(open(CONF_FNAME, 'r'))
  except: 1
  return {}

conf = read_conf()


def mgd(m, i):
  return m.group(i).lower()

JS_COM_REX = re.compile(r'^\s*\/\/')
JS_MOD_REX = re.compile(r'\b(class)\s+([a-zA-Z0-9_]+)')
JS_MOJ_REX = re.compile(r'\b\s*var\s+([a-zA-Z0-9_]+)\s*=\s*\(function\(\)\s*\{')
JS_DEF_REX = re.compile(r'\bthis\.([a-zA-Z0-9_]+)\s*=[^=]')
JS_D3F_REX = re.compile(r'\bvar\s+([a-zA-Z0-9_]+)\s*=\s*function\(')
JS_DCF_REX = re.compile(r'\b([#a-zA-Z0-9_]+)\s*\([^)]+\)\s*\{')
JS_DCF_NOT = [ 'if', 'function', 'forEach', 'for', 'while', 'switch' ]
  #
def index_js_line(idx, path, line, l):
  if re.match(JS_COM_REX, line): return
  p = path + ':' + str(l)
  m = re.search(JS_MOD_REX, line)
  l = line.rstrip().replace('\t', '  ')
  if m:
    idx['entries'].append({
      'l': 'js', 'p': p,  't': 'mod', 'k': mgd(m, 2), 'tt': m.group(1), 'L': l })
  m = re.search(JS_MOJ_REX, line)
  if m:
    idx['entries'].append({
      'l': 'js', 'p': p,  't': 'mod', 'k': mgd(m, 1), 'tt': 'j', 'L': l })
  m = re.search(JS_DEF_REX, line)
  if m:
    idx['entries'].append({
      'l': 'js', 'p': p,  't': 'def', 'k': mgd(m, 1), 'tt': '-', 'L': l })
  m = re.search(JS_D3F_REX, line)
  if m:
    idx['entries'].append({
      'l': 'js', 'p': p,  't': 'def', 'k': mgd(m, 1), 'tt': 'p', 'L': l })
  m = re.search(JS_DCF_REX, line)
  if m and (m.group(1) not in JS_DCF_NOT):
    idx['entries'].append({
      'l': 'js', 'p': p,  't': 'def', 'k': mgd(m, 1), 'tt': 'c', 'L': l })

def index_js(idx, path):
  if path.endswith('.min.js'): return
  l = 0
  for line in read_lines(path):
    l = l + 1
    index_js_line(idx, path, line, l)

RB_COM_REX = re.compile(r'^\s*#')
RB_DEF_REX = re.compile(r'\bdef\s+([a-zA-Z0-9.:_]+)')
RB_MOD_REX = re.compile(r'\b(module|class)\s*([a-zA-Z0-9_][a-zA-Z0-9.:_]*)')
RB_CON_REX = re.compile(r'\b([A-Z_0-9]+)\s*=[^=]')
#RB_ASS_REX = re.compile(r'\b([^=]+)\s*=\s*[^=>]')
  #
def index_rb_line(idx, path, line, l):
  if re.match(RB_COM_REX, line): return
  p = path + ':' + str(l)
  m = re.search(RB_DEF_REX, line)
  l = line.rstrip().replace('\t', '  ')
  if m:
    idx['entries'].append({
      'l': 'ruby', 'p': p,  't': 'def', 'k': mgd(m, 1), 'tt': '-', 'L': l })
  m = re.search(RB_MOD_REX, line)
  if m:
    idx['entries'].append({
      'l': 'ruby', 'p': p,  't': 'mod', 'k': mgd(m, 2), 'tt': m.group(1), 'L': l })
  m = re.search(RB_CON_REX, line)
  if m:
    idx['entries'].append({
      'l': 'ruby', 'p': p,  't': 'con', 'k': mgd(m, 1), 'tt': '-', 'L': l })

def index_rb(idx, path):
  l = 0
  for line in read_lines(path):
    l = l + 1
    index_rb_line(idx, path, line, l)

#def index_flo_line(idx, path, line, l):
#  print(line.strip())

def index_flo(idx, path):
  #l = 0
  #for line in read_lines(path):
  #  l = l + 1
  #  index_flo_line(idx, path, line, l)
  None

#SCSS_X_REX = re.compile(r'([.#][^.#{}, ]+)+\s*($|\{)')
#  #
#def index_scss_line(idx, path, line, l):
#  print(line.strip())
#  for m in re.findall(SCSS_X_REX, line.strip()):
#    print('mmm:' + m)

def index_scss(idx, path):
  #l = 0
  #for line in read_lines(path):
  #  l = l + 1
  #  index_scss_line(idx, path, line, l)
  None

indexers = [
  { 'rex': '\.rb$', 'fun': index_rb },
  { 'rex': '\.js$', 'fun': index_js },
  { 'rex': '\.flo$', 'fun': index_flo },
  { 'rex': '\.css$', 'fun': index_scss },
  { 'rex': '\.scss$', 'fun': index_scss },
    ]

def post_index(idx, path, index):
  fn = os.path.basename(path)
  idx['entries'].append({
    'l': 'file', 'p': path + ':0', 't': 'fna', 'k': fn, 'tt': '-', 'L': path })
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
    ): return post_index(idx, path, indexer['fun'](idx, path))
  return {}

#
# switches

if '--conf' in sys.argv:
  print(conf)
  exit(0)

if '--json' in sys.argv:
  print('{')
  print('  entries: [')
  for e in idx['entries']:
    print('    ' + json.dumps(e) + ',')
  print('  ],')
  print('}')
  #print(json.dumps(idx, indent=2))
  exit(0)

#
# index

idx = { 'entries': [] }

#glo = sys.argv[1] if len(sys.argv) > 1 else '**/*'
glo = '**/*'
paths = glob.glob(glo, recursive=True)

def is_not_excluded(path):
  for x in conf.get('exclude', []):
    if x.endswith('/') and path.startswith(x): return False
    if fnmatch.fnmatch(path, x): return False
  return True
paths = filter(is_not_excluded, paths)

for p in paths: index(idx, p)

#
# save

with open(INDEX_FNAME, 'wb') as file:
  pickle.dump(idx, file)

