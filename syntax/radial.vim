
" MIT license

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

"syn case match

syn keyword radialExpression define process_definition
syn keyword radialExpression filter repeat wait
syn keyword radialExpression concurrence sequence
syn keyword radialExpression concurrent_iterator concurrent-iterator citerator
hi def link radialExpression Special

syn region radialComment start="#" end="\n"
hi def link radialComment Comment

syn match radialKey "[^ :]*: "
hi def link radialKey Keyword

"syn match radialExpName ".+"
"hi def link radialExpName Comment

let b:current_syntax = "radial"

