
# regitdiffstat.pl

print "\n";

while (<>) {

  if (/\A ([^\d].+)/) {
    print $1 . "\n";
  }
  elsif (/^ \d+ files changed,/) {
    print "\n" . $_;
  }
  else {
    print $_;
  }
}

