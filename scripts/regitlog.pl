
# regitlog.pl

while (<>) {

  $_ =~ s/\s+$//g;
  print $_ . "\n";
}

