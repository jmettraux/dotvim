
# oldfiles.pl

use Cwd;
use Path::Class;


my $home = $ENV{'HOME'};
my @lines = ();

while (<>) {

  if (/^\d+: ([^ \n]+)/) {

    if ($1 =~ /COMMIT_EDITMSG/) { next; }
    if ($1 =~ /NetrwTreeListing/) { next; }
    if ($1 =~ /bash-fc-/) { next; }
    if ($1 =~ /==ListFiles/) { next; }
    if ($1 =~ /==GitLog/) { next; }
    if ($1 =~ /==GitDiff/) { next; }
    if ($1 =~ /==GitBlame/) { next; }
    if ($1 =~ /==GitCommit/) { next; }
    if ($1 =~ /\/private\/var\//) { next; }
    if ($1 =~ /\/mutt-/) { next; }

    my $path = $1;
    if ($path =~ /^~/) { $path = $home . substr($path, 1); }
    $path = file($path)->relative(getcwd());

    push @lines, $path;
  };
}

print "== recent\n";
print join("\n", @lines);

print "\n";

