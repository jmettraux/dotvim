
# scripts/openai.py

import os, sys, re
import json
import openai
from pathlib import Path


# primitive but...
#
def count_tokens(s):
  return \
    len(re.findall(r'\w+', s)) + \
    len(re.findall(r'\s', s)) + \
    len(re.findall(r'[^\w\s]', s))


with open(os.path.expanduser('~') + '/.vim/.openai.key.txt', 'r') as file:
  openai.api_key = file.read().strip()

fname_last = '.openai.last.py'
fname_messages = '.openai.messages.py'
model = 'gpt-3.5-turbo'
temperature = 0.7

whole_tokens = 4096
max_tokens = 1400
rem_tokens = whole_tokens - max_tokens

lines = sys.stdin.read().strip()

Path(fname_messages).touch()

prompt = { "role": "user", "content": lines }

all_messages = []
  #
with open(fname_messages) as f:
  while line := f.readline():
    all_messages.append(json.loads(line.strip()))
  #
all_messages.append(prompt)

i = 1
l = len(all_messages)
  #
while 1:
  js = json.dumps(all_messages[-(i+1):])
  if count_tokens(js) > rem_tokens: break
  i = i + 1
  if i >= l: break

messages = all_messages[-i:]
l = count_tokens(json.dumps(messages))

#
# call the API...

response = openai.ChatCompletion.create(
  model = model,
  messages = messages,
  n = 1,
  max_tokens = max_tokens,
  stop = None,
  temperature = temperature)

with open(fname_last, 'w') as f:
  print(response, file=f)

with open(fname_messages, 'a') as f:
  f.write(json.dumps(prompt))
  f.write("\n")
  f.write(json.dumps(response.choices[0].message))
  f.write("\n")

print(f">>> {model} i:{i} l:{l} >>>")
print(response.choices[0].message.content)
print(f"<<< {model} <<< .")
print()

