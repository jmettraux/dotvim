
# regitdiff.pl

my $fname = '(none)';

while (<>) {

  if (/\Adiff --git a\/(.+) b\//) {
    $fname = $1;
  }
  elsif (/\A@@ [-+]\d+,\d+ [-+](\d+),/) {
    #print "\n" . $fname . ':' . $1 . " ---+++\n";
    print "\n" . sprintf("%-79s\.\n", $fname . ':' . $1 . " ---+++");
  }
  elsif (/\A(---|\+\+\+) [ab]\//) {}
  elsif (/\Aindex [0-9a-fA-F]+\.\.[0-9a-fA-F]+/) {}
  else {
    $_ =~ s/\s+$//g;
    print $_ . "\n";
  }
}

print "\n";

