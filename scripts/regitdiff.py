G = subprocess.check_output([ 'git', 'rev-parse', '--show-toplevel' ]).strip()
    subprocess.Popen(cmd, shell=True, cwd=G, stdout=subprocess.PIPE).stdout)
  l = exec_to_line('git diff --numstat -- ' + path)
  if m: return '+' + m.group(1) + '-' + m.group(2)
  return ''