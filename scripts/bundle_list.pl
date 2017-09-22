
# bundle_list.pl

foreach(split(/\n/, `bundle list`)) {
  if (/^  \* ([^ ]+)\s+\(([^)]+)/) {
    my $name = $1;
    my $version = $2;
    my $path = `bundle show $1`; $path =~ s/\s+$//g;
    printf("%-21s %9s %s\n", $name, $version, $path)
  }
}
print("\n");

