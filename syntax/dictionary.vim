
" MIT licensed

hi! dicWord cterm=NONE ctermfg=darkyellow ctermbg=16
hi! dicFrom cterm=NONE ctermfg=white ctermbg=16


"
" dictionary

syn match dicWord '\v  [a-z][^ ]+$'

syn match dicWord '\v  [A-Z][^ ]+ ' contained
syn match dicLine '\v  [A-Z][^ ]+ \\' contains=dicWord

syn match dicFrom '\vFrom .+$'


let b:current_syntax = "dictionary"

