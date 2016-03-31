
" MIT license

" Quit when a (custom) syntax file is already loaded
if exists("b:current_syntax")
  finish
endif

syn match radialSpecial ";"
syn match radialSpecial "\\"
syn match radialHead /^[ ]*[^ ;#\[\]{}()]\+/
syn match radialHead /;\@<=[ ]*[^ ;#\[\]{}()]\+/
syn region radialComment start="#" end="\n"

syn region radialString start=+"+  skip=+\\"+  end=+"+
syn region radialString	start=+'+  skip=+\\'+  end=+'+

hi def link radialHead Keyword
hi def link radialString String
hi def link radialComment Comment
hi def link radialSpecial Special

let b:current_syntax = "radial"

