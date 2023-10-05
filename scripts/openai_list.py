
# scripts/openai.py

import os, sys, re
import json
import openai
from pathlib import Path


with open(os.path.expanduser('~') + '/.vim/.openai.key.txt', 'r') as file:
  openai.api_key = file.read().strip()

models = openai.Model.list()
  #
def id(x):
  return x.id
for m in sorted(map(id, models.data)):
  #print(m, end=' ')
  print(m)

