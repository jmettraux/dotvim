
# oldfiles.pl

use Cwd;
use Path::Class;

#use strict;
use warnings;


my $home = $ENV{'HOME'};

my @all = ();
my @slash = ();
my @dotdot = ();
my @dot = ();

while (<>) {

  if (/^\d+: ([^ \n]+)/) {

    if ($1 =~ /COMMIT_EDITMSG/) { next; }
    if ($1 =~ /NetrwTreeListing/) { next; }
    if ($1 =~ /bash-fc-/) { next; }
    if ($1 =~ /==[A-Z]/) { next; }
    if ($1 =~ /\/private\/var\//) { next; }
    if ($1 =~ /\/mutt-/) { next; }

    my $path = $1;
    if ($path =~ /^~/) { $path = $home . substr($path, 1); }
    $path = file($path)->relative(getcwd());

    push @all, $path;

    if ($path =~ /^\//) { push @slash, $path; }
    elsif ($path =~ /^\.\./) { push @dotdot, $path; }
    else { push @dot, $path; }
  };
}

print "== recent (10)\n";
print join("\n", @all[0..9]), "\n";

    #let m = matchlist(l, '\v^([│├─└  ]+) (.+)$')

print "== recent (tree)\n";

## @dot

@dot = sort(@dot);
@dotdot = sort(@dotdot);
@slash = sort(@slash);

my $previous;
my $current;
my $next;

sub tree { my ($prv, $cur, $nxt) = @_;
  my @aprv = split("/", $prv);
  my @acur = split("/", $cur);
  my @anxt = split("/", $nxt);
  my $lprv = scalar(@aprv);
  my $lcur = scalar(@acur);
  my $lnxt = scalar(@anxt);
  if ( ! $nxt) { return "└── " };
  return "├── ";
}

print ".\n";
for (my $i = 0; $i < scalar(@dot); $i++) {
  $previous = $current;
  $current = $dot[$i];
  $next = $dot[$i + 1];
  print tree($previous, $current, $next), $current, "\n";
}
#foreach $path (@dot) {
#  print "├── ", $path, "\n";
#}

## @dotdot

print "..\n";
my $l = scalar(@dotdot);
for (my $i = 0; $i < $l; $i++) {
  my $cur = substr($dotdot[$i], 3);
  my $nxt = $dotdot[$i + 1];
  print(($nxt ? "├── " : "└── "), $cur, "\n");
}

## @slash

print join("\n", @slash), "\n";

print "\n";

