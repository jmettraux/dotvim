
" MIT licensed

" Quit when a (custom) syntax file was already loaded
"if exists("b:current_syntax")
"  finish
"endif

hi! stoFilename cterm=NONE ctermfg=green ctermbg=16
hi! stoDirname cterm=NONE ctermfg=darkgreen ctermbg=16
hi def link stoTree Comment
hi def link stoSize Comment
hi def link stoLines Comment
hi def link stoSummary Comment
hi! stoGit cterm=NONE ctermfg=white ctermbg=16
hi! stoExt cterm=NONE ctermfg=grey ctermbg=16

syn match stoTree '\v[├│└─  |`-]+ ' contained
syn match stoSize '\v[0-9.]+[KMGTPE]?( |$)' contained
syn match stoLines '\v[0-9.]+L( |$)' contained
syn match stoGit '\v(\+\d+-\d+|untracked|new)( |$)' contained
syn match stoFilename '\v[-A-Za-z0-9 \(\)_.+]+' contained contains=stoExt,stoSize,stoLines,stoGit,stoDirname
syn match stoLine '\v^[ |│├└`.]([│├└─  |`-]+ )?.+' contains=stoTree,stoFilename
syn match stoLine '\v^[^ |│├└`]+/ .+$' contains=stoFilename

syn match stoFilename '\v^[^|` ]+' contains=stoDirname
  " for the top lib/ or whatever...

syn match stoExt '\v\.[a-zA-Z]+( )@=' contained
syn match stoDirname '\v.+/' contained

let b:current_syntax = "showtreeout"

