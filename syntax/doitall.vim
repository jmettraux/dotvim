
" MIT licensed

" Quit when a (custom) syntax file was already loaded
"if exists("b:current_syntax")
"  finish
"endif

hi! diaKey cterm=NONE ctermfg=grey ctermbg=16
hi! diaString cterm=NONE ctermfg=yellow ctermbg=16
hi! diaTable cterm=NONE ctermfg=darkgrey ctermbg=16
"hi def link diaTable Comment

syn region diaString start=+"+  skip=+\\"+  end=+"+
syn region diaString start=+'+  skip=+\\'+  end=+'+
"syn region diaString start=+/+  skip=+\\/+  end=+/+
syn match diaKey '\v[a-z][-a-zA-Z0-9_]*'
syn match diaTable '\v\+.+\+'
syn match diaTable '\v( \| |^\| | \|$)'

let b:current_syntax = "doitall"

