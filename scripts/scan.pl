
# scan.pl

$i = 1;
while (<>) {
  if (/^\s*(module\s+|class\s+|def\s+[^\s.]+|\bvar\s+.+\s+=\s+\(?function\b)|\s+this\.\S+\s+=\s+function\b/) {
    printf("%5d %s", $i, $_);
  };
  $i = $i + 1;
}

