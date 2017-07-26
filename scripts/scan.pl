
# scan.pl

$i = 1;
while (<>) {
  if (
    /^\s*
      (
        module\s+|
        class\s+|
        def\s+[^\s.]+|
        \bvar\s+.+\s+=\s+\(?function\b|
        public\b|protected\b|private\b
      )|
      \s+this\.\S+\s+=\s+function\b
    /x
  ) {
    printf("%5d %s", $i, $_);
  };
  $i = $i + 1;
}

