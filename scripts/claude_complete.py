
#
# scripts/claude_complete.py

import os, sys, re
import requests, json
from pathlib import Path

key_path = os.path.expanduser('~') + '/.vim/.claude.key.txt'


# primitive but...
#
def count_tokens(s):
  return \
    len(re.findall(r'\w+', s)) + \
    len(re.findall(r'\s', s)) + \
    len(re.findall(r'[^\w\s]', s))

role = 'user'

url = 'https://api.anthropic.com/v1/messages'
#agent = 'vim-claude-jmettraux'

fname_last = '.klaude.last.json'
fname_messages = '.klaude.messages.json'

aversion = '2023-06-01'
model = 'claude-sonnet-4-6'

whole_tokens = 16 * 1024
max_tokens = 1024
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
  "max_tokens": max_tokens }

headers = {
  #'User-Agent': agent,
  'anthropic-version': aversion,
  'Content-Type': 'application/json',
  'x-api-key': api_key }

#print(headers)
#print(data)

response = requests.post(url, data=json.dumps(data), headers=headers)
suc = response.status_code == 200
res = response.json() if suc else None
#print(res)
con = res['content'] if suc else None


with open(fname_last, 'w') as f:
  headers['x-api-key'] = '{claude-api-key}'
  print('{ headers:', file=f)
  print(json.dumps(headers, indent=2), file=f)
  print(', postdata:', file=f)
  print(json.dumps(data, indent=2), file=f)
  print(', response:', file=f)
  print(json.dumps(res, indent=2), file=f)
  print('}', file=f)

if suc:
  with open(fname_messages, 'a') as f:
    answer = { "role": res['role'], "content": res['content'] }
    f.write(json.dumps(prompt, indent=None))
    f.write("\n")
    f.write(json.dumps(answer, indent=None))
    f.write("\n")

it = res['usage']['input_tokens'] if suc else -1
ot = res['usage']['output_tokens'] if suc else -1
#tt = res['usage']['total_tokens']

print(f"<!--  {model}  i:{i} l:{l} -- it:{it} ot:{ot}  -->")
print()
if suc:
  print(re.sub(r'\s+$', '', con[0]['text'], flags=re.MULTILINE))
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

