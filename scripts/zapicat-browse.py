
#
# .vim/scripts/zapicat-browse.py

import os, re, sys, glob, json, pickle, shutil, subprocess


#W = 80
W = int(sys.argv[1])
#W, _ = shutil.get_terminal_size()

CONF_FNAME = '.zapicat'
INDEX_FNAME = '.zapicat.index'


#def to_list(x):
#  return x if isinstance(x, list) else [ x ]

#def exec_to_lines(cmd):
#  return map(
#    lambda l: l.decode().rstrip(),
#    subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).stdout)
#W = int(list(exec_to_lines('tput cols'))[0])

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

aliases = {
  'ru': 'ruby',
  'rb': 'ruby',
  'jscript': 'js',
  'javascript': 'js',
  'def': 'fun',
  'func': 'fun',
  'function': 'fun',
    }
shorts = {
  'ruby': 'rb',
  'def': 'df',
  'module': 'mo',
    }

key = None
  #
argv = sys.argv[2:]
if len(argv) > 0: key = argv.pop()
argv = list(map(lambda x: aliases.get(x, x), argv))
if len(argv) < 1: argv = None

def match(e, key):
  if key.endswith('%'): return e['k'].startswith(key[:-1])
  if key.startswith('%'): return e['k'].endswith(key[1:])
  return e['k'] == key

def count_wspace(string):
  m = re.search(r'^\s+', string)
  return len(m.group()) if m else 0

#
# filter and prepare rendering

es = []
fmx = 0
nmx = 0
kmx = 0
ws = 9999
for e in idx['entries']:

  if argv and not(e['l'] in argv or e['t'] in argv): continue
  if key and not match(e, key): continue

  ss = e['p'].split(':')
  e['F'] = ss[0]
  e['N'] = ss[1]
  e['L'] = idx['lines'][e['p']].replace('\t', '  ')
  ws = min(ws, count_wspace(e['L']))
  fmx = max(fmx, len(e['F']))
  nmx = max(nmx, len(e['N']))
  kmx = max(kmx, len(e['k']))
  es.append(e)

#
# render

for e in es:
  t = shorts.get(e['t'], e['t'][:2])
  #l = shorts.get(e['l'], e['l'][:2])
  s = f"%{fmx}s:%-{nmx}s %-{kmx}s %s %s" % ( e['F'], e['N'], e['k'], t, e['L'])
  if len(s) > W: s = s[:W-1] + '‣'
  print(s)

