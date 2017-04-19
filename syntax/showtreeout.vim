
" MIT licensed

" Quit when a (custom) syntax file was already loaded
"if exists("b:current_syntax")
"  finish
"endif

hi! stoFilename cterm=NONE ctermfg=green ctermbg=16
hi def link stoSummary Comment

syn match stoFilename '\v/@<=[^\/]+$'
syn match stoSummary '\v^\d+ .+$'

let b:current_syntax = "showtreeout"

