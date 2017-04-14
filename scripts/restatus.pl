
# MIT Licensed

while (<>) {
  if (/\A\s+new file:\s+(.+)\n/) {
    print $1 . "  (new file)\n";
  }
  elsif (/\A ([^\(]+\s+| \d+ [-+]+)\z/) {
    print $1 . "\n";
  }
  elsif (/\A\s\d+ /) {
    print "#\n#" . $_;
  }
}

