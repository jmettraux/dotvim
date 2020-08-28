
# regitdiff.pl

my $fname = '(none)';

while (<>) {

  if (/\Adiff --git a\/(.+) b\//) {
    $fname = $1;
  }
  elsif (/\A@@ [-+]\d+,\d+ [-+](\d+),/) {
    print "\n" . sprintf("%-79s\.\n", $fname . ':' . $1 . " ---+++");
  }
  elsif (/\A(commit |Author: |Date:   )(.+)$/) {
    print sprintf("%-79s\.\n", $1 . $2)
  }
  elsif (/\A(---|\+\+\+) [ab]\//) {}
  elsif (/\Aindex [0-9a-fA-F]+\.\.[0-9a-fA-F]+/) {}
  elsif (/\Anew file mode \d/) {}
  elsif (/\A--- \/dev\/null/) {}
  else {
    $_ =~ s/\s+$//g;
    print $_ . "\n";
  }
}

print "\n";

