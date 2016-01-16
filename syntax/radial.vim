
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

syn keyword radialExpression loop break
syn keyword radialExpression if else ife unless unlesse elsif elif
syn keyword radialExpression or and
syn keyword radialExpression ==

syn region radialComment start="#" end="\n"

syn match radialKey "[^ :]+: "
syn match radialKey "\$([^)]*)"

"syn match radialExpName ".+"
"hi def link radialExpName Comment

hi def link radialExpression Special
hi def link radialComment Comment
hi def link radialKey Keyword
hi def link radialKey Keyword

let b:current_syntax = "radial"

