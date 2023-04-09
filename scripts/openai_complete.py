
# scripts/openai.py

import os, sys
import json
import openai
from pathlib import Path


with open(os.path.expanduser('~') + '/.vim/.openai.key.txt', 'r') as file:
  openai.api_key = file.read().strip()

fname_last = '.openai.last.py'
fname_messages = '.openai.messages.py'
model = 'gpt-3.5-turbo'
max_tokens = 2000
temperature = 0.7

lines = sys.stdin.read().strip()

Path(fname_messages).touch()

prompt = { "role": "user", "content": lines }

messages = []
  #
with open(fname_messages) as f:
  while line := f.readline():
    messages.append(json.loads(line.strip()))
  #
messages.append(prompt)
#print("(((")
#print(messages)
#print(")))")

#response = openai.Completion.create(model="ada", prompt="Hello world")
#print(response.choices[0].text)

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

#print()
print('>>> ' + model + ' >>>')
print(response.choices[0].message.content)
print('<<< ' + model + ' <<< .')
print()

