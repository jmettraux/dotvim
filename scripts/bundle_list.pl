
# bundle_list.pl

my @gems = grep(/^  \* /, split(/\n/, `bundle list 2>/dev/null`));
my @paths = split(/\n/, `bundle show --paths 2>/dev/null`);
my $home = $ENV{'HOME'};

for ($i=0; $i <= $#gems; $i++) {
  $gems[$i] =~ /^  \* ([^ ]+)\s+\(([^ )]+)/;
  my $gem = $1;
  my $version = $2;
  my $path = ($paths[$i] =~ s/$home/~/gr);
  printf("%-21s %9s %s\n", $gem, $version, $path)
}
print("\n");

