
# restatus.pl

while (<>) {

#print ">>>" . $_;
  if (/\A\s+new file:\s+(.+)\n/) {
    print $1 . "  (new file)\n";
  }
  #elsif (/\A\s+modified:\s+(.+)\n/) {
  #  print $1 . "  (modified)\n";
  #}
  elsif (/\A ([^\(]+\s+\|)[ ]*(\d+) ([-+]+)/) {
    print $1 . ' ' . $3 . ' ' . $2 . "\n";
  }
  elsif (/\A\s\d+ /) {
    print "#\n#" . $_;
  }
}

