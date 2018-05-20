
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
        public\b|protected\b|private\b|
        before\s+:[a-z]+|after\s+:[a-z]+|
        describe\s+(['"A-Za-z])|context\s+['"]|it\s+['"]
      )|
      \s+this\.\S+\s+=\s+function\b
    /x ||
    /\bFIXME|TODO\b/
  ) {
    printf("%5d %s", $i, $_);
  };
  $i = $i + 1;
}

