
# scripts/openai.py

import os, sys
#import json
import openai

lines = sys.stdin.read().strip()

with open(os.path.expanduser('~') + '/.vim/.openai.key.txt', 'r') as file:
  openai.api_key = file.read().strip()

#completion = openai.Completion.create(model="ada", prompt="Hello world")
#print(completion.choices[0].text)

model = 'gpt-3.5-turbo'

messages = []
messages.append({ "role": "user", "content": lines })

response = openai.ChatCompletion.create(
  model = model,
  messages = messages,
  n = 1,
  max_tokens = 2000,
  stop = None,
  temperature = 0.7)

with open('.openai.last.py', 'w') as f:
  print(response, file=f)

messages.append(response.choices[0].message)
#messages.append(json.dumps(response.choices[0].message))

with open('.openai.messages.py', 'w') as f:
  print(messages, file=f)

print()
print('>>> ' + model + ' >>>')
print(response.choices[0].message.content)
print('<<< ' + model + ' <<< .')
print()

