
" MIT licensed

hi! dicWord cterm=NONE ctermfg=darkyellow ctermbg=16
hi! dicFrom cterm=NONE ctermfg=white ctermbg=16


"
" dictionary

syn match dicWord '\v  [a-z][^ ]+$'
syn match dicFrom '\vFrom .+$'


let b:current_syntax = "dictionary"

