
# MIT Licensed

my $fname = '(none)';

while (<>) {
  if (/\Adiff --git a\/(.+) b\//) {
    $fname = $1;
  }
  elsif (/\A@@ [-+](\d+),/) {
    print "\n" . $fname . ':' . $1 . " ---+++\n";
  }
  elsif (/\A(---|\+\+\+) [ab]\//) {}
  elsif (/\Aindex [0-9a-fA-F]+\.\.[0-9a-fA-F]+/) {}
  elsif (/\A\s+\z/) {} # drop empty lines
  else {
    print $_;
  }
}

