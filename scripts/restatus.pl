
# MIT Licensed

while (<>) {
  if (/\A\s+modified:\s+(.+)\n/) {
    print $1 . "  (modified)\n"
  }
  elsif (/\A\s+new file:\s+(.+)\n/) {
    print $1 . "  (new file)\n"
  }
  elsif (/\A \d+ /) {
    print "#\n#" . $_;
  }
}

