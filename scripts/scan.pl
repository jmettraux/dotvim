
# scan.pl

$i = 1;
while (<>) {
  if (
    /^\s*
      (
        module\s+|
        class\s+|
        def\s+[^\s.]+|
        alias\s+[^\s.]+\s+[^\s.]+|
        attr_(reader|accessor|writer)\s+|
        \bvar\s+.+\s+=\s+\(?function\b|
        public\b|protected\b|private\b|
        Option\b|Public\b|Sub\b|Function\b|
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

