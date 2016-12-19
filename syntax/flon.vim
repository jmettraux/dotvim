
" MIT license

" Quit when a (custom) syntax file is already loaded
if exists("b:current_syntax")
  finish
endif

syn match flonSpecial ";"
syn match flonSpecial "\\"
syn match flonHead /^[ ]*[^ ;#\[\]{}()]\+/
syn match flonHead /;\@<=[ ]*[^ ;#\[\]{}()]\+/
syn match flonKey /\v\zs[^\s]+\ze[\s]*:/
syn keyword flonKey if unless

syn region flonComment start="#" end="\n"

syn region flonString start=+"+  skip=+\\"+  end=+"+
syn region flonString start=+'+  skip=+\\'+  end=+'+
syn region flonString start=+/+  skip=+\\/+  end=+/+

hi def link flonHead Keyword
hi def link flonString String
hi def link flonComment Comment
hi def link flonSpecial Special
hi def link flonKey Keyword

let b:current_syntax = "flon"

