
" MIT licensed

" Quit when a (custom) syntax file was already loaded
"if exists("b:current_syntax")
"  finish
"endif

hi! stoFilename cterm=NONE ctermfg=green ctermbg=16
hi! stoDirname cterm=NONE ctermfg=darkgreen ctermbg=16
hi def link stoTree Comment
hi def link stoSize Comment
hi def link stoSummary Comment

syn match stoSummary '\v^\d+ .+$'

syn match stoDirname  '\v^[a-zA-Z].*$'
  "
syn match stoTree '\v^[├│└─  ]+' contained
syn match stoDirname  '\v[-A-Za-z0-9 \(\)_.]+\/' contained
syn match stoFilename '\v[-A-Za-z0-9 \(\)_.]+ ' contained
syn match stoSize '\v[0-9.]+[KMGTPE]?$' contained
syn match stoLine '\v^[├│└─  ]+ .+' contains=stoTree,stoDirname,stoFilename,stoSize

let b:current_syntax = "showtreeout"

