
# scripts/openai.py

import os, sys, re
import json
from openai import OpenAI
from pathlib import Path

key_path = os.path.expanduser('~') + '/.vim/.openai.key.txt'
  #
api_key = None
with open(key_path, 'r') as file: api_key = file.read().strip()
  #
client = OpenAI(api_key=api_key)

models = client.models.list()
  #
def id(x):
  return x.id
for m in sorted(map(id, models.data)):
  #print(m, end=' ')
  print(m)

