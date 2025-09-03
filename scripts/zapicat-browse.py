
#
# .vim/scripts/zapicat-browse.py

import os, re, sys, glob, json, pickle, shutil, subprocess

#print(sys.argv)

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
  #'def': 'd',
  #'module': 'm',
    }

key = None
  #
argv = sys.argv[2:]
if len(argv) > 0: key = argv.pop()
argv = list(map(lambda x: aliases.get(x, x), argv))
if len(argv) < 1: argv = None
  #
if (key): key = key.lower()


def match(e, key):
  #if key.endswith('%'): return e['k'].startswith(key[:-1])
  #if key.startswith('%'): return e['k'].endswith(key[1:])
  #return e['k'] == key
  return e['k'].find(key) > -1

def count_wspace(string):
  m = re.search(r'^\s+', string)
  return len(m.group()) if m else 0

#
# filter and prepare rendering

es = []
fmx = 0
nmx = 0
ws = 9999
for e in idx['entries']:

  if argv and not(e['l'] in argv or e['t'] in argv): continue
  if key and not match(e, key): continue

  ss = e['p'].split(':')
  e['F'] = ss[0]
  e['N'] = ss[1]
  ws = min(ws, count_wspace(e['L']))
  fmx = max(fmx, len(e['F']))
  nmx = max(nmx, len(e['N']))
  es.append(e)

fmx = fmx + 1

#
# render

for e in es:
  t = shorts.get(e['t'], e['t'][:1])
  #l = shorts.get(e['l'], e['l'][:2])
  s = f"%{fmx}s:%-{nmx}s %s %s" % (e['F'], e['N'], t, e['L'][ws:])
  if len(s) > W: s = s[:W-1] + '‣'
  print(s)

