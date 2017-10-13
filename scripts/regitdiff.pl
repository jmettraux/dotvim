
# regitdiff.pl

print "\n=============================================vv== changes, point by point ==vv==\n\n";

my $fname = '(none)';
my @files = ();

while (<>) {

  if (/\Adiff --git a\/(.+) b\//) {
    $fname = $1;
  }
  elsif (/\A@@ [-+]\d+,\d+ [-+](\d+),/) {
    my $f = $fname . ':' . $1 . " ---+++\n";
    print "\n" . $f;
    push @files, $f;
  }
  elsif (/\A(---|\+\+\+) [ab]\//) {}
  elsif (/\Aindex [0-9a-fA-F]+\.\.[0-9a-fA-F]+/) {}
  else {
    $_ =~ s/\s+$//g;
    print $_ . "\n";
  }
}

print "\n===========================================vv== summary of changed points ==vv==\n\n";
print join("", @files);
print "\n";

