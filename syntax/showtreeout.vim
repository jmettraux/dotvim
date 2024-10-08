
  " (<pattern>)@<=<match>  ~~~ positive lookbehind
  " <match>(<pattern>)@=   ~~~ positive lookahead
  " (<pattern>)@!<match>   ~~~ negative lookbehind
  " <match>(<pattern>)@!   ~~~ negative lookahead

hi! stoFilename cterm=NONE ctermfg=green ctermbg=16
hi! stoDirname cterm=NONE ctermfg=darkgreen ctermbg=16
hi def link stoTree Comment
hi! stoSize cterm=NONE ctermfg=238 ctermbg=16
hi! stoLines cterm=NONE ctermfg=darkgrey ctermbg=16
hi! stoMtime cterm=NONE ctermfg=238 ctermbg=16
hi def link stoSummary Comment
hi! stoGit cterm=NONE ctermfg=white ctermbg=16
hi! stoExt cterm=NONE ctermfg=grey ctermbg=16

syn match stoTree '\v[├│└─  |`-]+ ' contained
syn match stoSize '\v( )@<=[0-9.]+[KMGTPE]?( |$)' contained
syn match stoLines '\v[0-9.]+L ' contained
syn match stoMtime '\v([0-9]+[dhms])+( |$)' contained
syn match stoGit '\v(\+\d+-\d+|untracked|new)( |$)' contained
syn match stoFilename '\v[-A-Za-z0-9 \(\)_.+]+' contained contains=stoExt,stoSize,stoLines,stoMtime,stoGit,stoDirname
syn match stoLine '\v^[ |│├└`.]([│├└─  |`-]+ )?.+' contains=stoTree,stoFilename
syn match stoLine '\v^[^ |│├└`]+/ .+$' contains=stoFilename

syn match stoFilename '\v^[^|` ]+' contains=stoDirname
  " for the top lib/ or whatever...

syn match stoExt '\v\.[a-zA-Z0-9]+( )@=' contained
syn match stoDirname '\v[-a-zA-Z0-9_.]+/' contained

let b:current_syntax = "showtreeout"

