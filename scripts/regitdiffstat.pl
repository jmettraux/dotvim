
# regitdiffstat.pl

print "\n";

while (<>) {

  if (/\A ([^\d].+)/) {
    print $1 . "\n";
  }
  else {
    print $_;
  }
}

