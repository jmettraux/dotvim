
# my .vim stuff

Nothing fancy here.

I don't use gvim or macvim.


## shortcuts

The `<leader>` is `;`.

* `;b` opens the buffers list, see below
* `;s` opens the tree of current source dir (src/ or lib/)
* `;d` opens the current Git diff for the current directory/repo
* `;l` opens the Git history for the current directory/repo
* `;k` scans the current file and open a readonly buffer of the results
* `;m` opens the Git blame for the current file
* `;Y` opens the Git history for the current file
* `;S` opens the Git commit list for the current file
* `;g` grep for the word under the cursor in the current subdir
* `;r` opens the last Ruby Rspec output


## commands

* `:Vg <regex> <dir>` open grep results for the given regex in the given dir
* `:Vt <dir>` open the tree view for the given dir


## the ListFiles

```
== buffers
listfiles.txt:21   4

== .vimspec
spec/functional/services/sentifi_spec.rb:178

== git status
lib/sg/services/sentifi.rb               | +++++++++--- 12
spec/functional/services/sentifi_spec.rb | +++--- 6
#
# lib/   files changed: 1, insertions:  9, deletions: 3
# spec/  files changed: 1, insertions:  3, deletions: 3
#
# ./     files changed: 2, insertions: 12, deletions: 6

== .vimgrep
  / '292aefb3'      _h___scripts_bli_js
  / '*'             _h___scripts_bli_js
  / 'to_zip'        lib/
  / 'transaction'   lib/

== .vimshorts
app/views/
scripts/
lib/sg/cases/
spec/functional/models/

== recent (3)
spec/functional/services/sentifi_spec.rb 4.9K
lib/sg/services/sentifi.rb 7.0K
spec/functional/cases/sentifi_spec.rb 2.0K
```


## credits

So many people to credit...


## license

MIT

