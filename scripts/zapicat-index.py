
#
# .vim/scripts/zapicat-index.py

import os, re, sys, glob

#conf = 

idx = {}

def index_rb(idx, path):
  print(path)

indexers = [
  { 'rex': '\.rb$', 'fun': index_rb }
    ]

def index(idx, path):
  for indexer in indexers:
    rex = indexer.get('rex')
    nam = indexer.get('name')
    pat = indexer.get('path')
    if (
      (rex and re.search(rex, path)) or
      (nam and nam == os.path.basename(path)) or
      (pat and path.ends_with(pat))
    ): return indexer['fun'](idx, path)
  return {}

glo = sys.argv[1] if len(sys.argv) > 1 else '**/*'
paths = glob.glob(glo, recursive=True)

for p in paths: index(idx, p)

