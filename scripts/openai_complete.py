
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
#model = 'gpt-3.5-turbo'
model = 'gpt-4'
temperature = 0.7

whole_tokens = 4096
max_tokens = 1400
rem_tokens = whole_tokens - max_tokens

lines = sys.stdin.read().strip()
m = re.match(r'^(#+\s+)(.*)', lines)
if m: lines = m.group(2)

prompt = { "role": "user", "content": lines }

Path(fname_messages).touch()

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

ct = response.usage.completion_tokens
pt = response.usage.prompt_tokens
#tt = response.usage.total_tokens

print(f"<!--  {response.model}  i:{i} l:{l} -- pt:{pt} ct:{ct}  -->")
print()
print(response.choices[0].message.content)
print()
print("<!-- . -->")
print()

