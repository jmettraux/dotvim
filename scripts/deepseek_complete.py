
#
# scripts/openai.py

import os, sys, re
import requests, json
from pathlib import Path

key_path = os.path.expanduser('~') + '/.vim/.deepseek.key.txt'


# primitive but...
#
def count_tokens(s):
  return \
    len(re.findall(r'\w+', s)) + \
    len(re.findall(r'\s', s)) + \
    len(re.findall(r'[^\w\s]', s))

role = 'user'

url = 'https://api.deepseek.com/chat/completions'
agent = 'vim-deepseek-jmettraux'

fname_last = '.deepseek.last.json'
fname_messages = '.deepseek.messages.json'
model = 'deepseek-chat'
#model = 'deepseek-reasoner'
#temperature = 1
temperature = 0.7

whole_tokens = 8192
max_tokens = 4096
rem_tokens = whole_tokens - max_tokens

lines = sys.stdin.read().strip()
m = re.match(r'^(#+\s+)(.*)', lines)
if m: lines = m.group(2)

mod = model
m = re.match(r'([-a-z0-9]+)\s*:\s*(.*)', lines)
if m: mod, lines = m.group(1), m.group(2)

prompt = { "role": role, "content": lines }

Path(fname_messages).touch()

all_messages = []
  #
with open(fname_messages) as f:
  while line := f.readline():
    line = line.strip()
    if line == '': break
    all_messages.append(json.loads(line))
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
#messages.insert(0, { "role": "user", "content": "ok" })
l = count_tokens(json.dumps(messages))

#
# call the API...

api_key = None
with open(key_path, 'r') as file: api_key = file.read().strip()

data = {
  "model": model,
  "messages": messages,
  "temperature": temperature,
  "max_tokens": max_tokens,
  "stream": False }

headers = {
  'User-Agent': agent,
  'Content-Type': 'application/json',
  'Authorization': 'Bearer ' + api_key }

response = requests.post(url, data=json.dumps(data), headers=headers)
suc = response.status_code == 200
res = response.json() if suc else None
cho = res['choices'][0]['message'] if suc else None

with open(fname_last, 'w') as f:
  headers['Authorization'] = 'Bearer {deepseek-api-key}'
  print('{ headers:', file=f)
  print(json.dumps(headers, indent=2), file=f)
  print(', postdata:', file=f)
  print(json.dumps(data, indent=2), file=f)
  print(', response:', file=f)
  print(json.dumps(res, indent=2), file=f)
  print('}', file=f)

if suc:
  with open(fname_messages, 'a') as f:
    f.write(json.dumps(prompt, indent=None))
    f.write("\n")
    f.write(json.dumps(cho, indent=None))
    f.write("\n")

ct = res['usage']['completion_tokens'] if suc else -1
pt = res['usage']['prompt_tokens'] if suc else -1
#tt = res['usage']['total_tokens']

print(f"<!--  {model}  i:{i} l:{l} -- pt:{pt} ct:{ct}  -->")
print()
if suc:
  print(re.sub(r'\s+$', '', cho['content'], flags=re.MULTILINE))
else:
  print('```')
  print(f'HTTP status code: {response.status_code}')
  print()
  print(response.text)
  print('```')
print()
print('<!-- . -->')
#print(f"<!-- {url} -->")
print()

