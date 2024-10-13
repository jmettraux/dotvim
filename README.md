
# my .vim stuff

Nothing fancy here.

I don't use gvim or macvim.


## deps

```
# cd /usr/local/bin && ln -s python3 python
```

## ~/.vim_python

```
$ mdkir ~/.vim_python
$ python -m venv ~/.vim_python
$ cd ~/.vim_python
$ bin/pip install openai
```


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


## credits

So many people to credit...


## license

MIT

