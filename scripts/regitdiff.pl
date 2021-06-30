  elsif (/\A@@ [-+]\d+([, ]\d+)? [-+](\d+)/) {
    print "\n" . sprintf("%-79s\.\n", $fname . ':' . $2 . " ---+++");
  }
  elsif (/\A(commit |Author: |Date:   )(.+)$/) {
    print sprintf("%-79s\.\n", $1 . $2)
  elsif (/\Anew file mode \d/) {}
  elsif (/\A--- \/dev\/null/) {}