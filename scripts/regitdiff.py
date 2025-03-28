
#
# regitdiff.py

#my $fname = '(none)';
#
#while (<>) {
#
#  if (/\Adiff --git a\/(.+) b\//) {
#    $fname = $1;
#  }
#  elsif (/\A@@ [-+]\d+([, ]\d+)? [-+](\d+)/) {
#    print "\n" . sprintf("%-79s\.\n", $fname . ':' . $2 . " ---+++");
#  }
#  elsif (/\A(commit |Author: |Date:   )(.+)$/) {
#    print sprintf("%-79s\.\n", $1 . $2)
#  }
#  elsif (/\A(---|\+\+\+) [ab]\//) {}
#  elsif (/\Aindex [0-9a-fA-F]+\.\.[0-9a-fA-F]+/) {}
#  elsif (/\Anew file mode \d/) {}
#  elsif (/\A--- \/dev\/null/) {}
#  else {
#    $_ =~ s/\s+$//g;
#    print $_ . "\n";
#  }
#}
#
#print "\n";

import re, sys, subprocess

W = str(int(sys.argv[1]) - 1)
G = subprocess.check_output([ 'git', 'rev-parse', '--show-toplevel' ]).strip()

def exec_to_lines(cmd):
  return map(
    lambda l: l.decode().rstrip(),
    subprocess.Popen(cmd, shell=True, cwd=G, stdout=subprocess.PIPE).stdout)
def exec_to_line(cmd):
  try:
    return list(exec_to_lines(cmd))[0]
  except:
    return False

def get_numstat(path):
  l = exec_to_line('git diff --numstat -- ' + path)
  if not l: return ''
  m = re.match(r'^(\d+)\s+(\d+)', l)
  if m: return '+' + m.group(1) + '-' + m.group(2)
  return ''

def get_log_numstat(commit, path):
  ls = list(exec_to_lines('git log -1 --numstat ' + commit + ' -- ' + path))
  m = re.match(r'^(\d+)\s+(\d+)', ls.pop())
  if m: return '+' + m.group(1) + '-' + m.group(2)
  return ''


fname = None
stat = None
commit = None


for line in sys.stdin:

  l = line.rstrip()

  if not(fname): l = line.strip()
    # for the commit message

  m = re.match(r'commit ([a-zA-Z0-9]{40})$', l)
  if m:
    commit = m.group(1)
    print('Commit: ' + commit)
    continue

  m = re.match(r'diff --git a/(.+) b/(.+)$', l)
  if m:
    fname = m.group(2)
    stat = get_log_numstat(commit, fname) if commit else get_numstat(fname)
    continue

  m = re.match(r'@@ [-+]\d+([, ]\d+)? [-+](\d+)', l)
  if m:
    print()
    print(("%-" + W + "s.") % (fname + ':' + m.group(2) + ' ---+++   ' + stat))
    continue

  if re.match(r'--- a/', l): continue
  if re.match(r'\+\+\+ b/', l): continue
  if re.match(r'index [0-9a-fA-F]+\.\.[0-9a-fA-F]+ \d+', l): continue

  print(l)

print()

