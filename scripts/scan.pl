
# scan.pl

$i = 1;
while (<>) {
  if (/^\s*(module\s+|class\s+|def\s+[^\s.]+|\bfunction\b)/) {
    printf("%5d %s", $i, $_);
  };
  $i = $i + 1;
}

