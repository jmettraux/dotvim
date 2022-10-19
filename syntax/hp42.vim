
" MIT licensed


" in the vimrc file itself:
"au BufRead *.hp42 set filetype=hp42


" Quit when a (custom) syntax file is already loaded
if exists("b:current_syntax")
  finish
endif


syn match hp42Special "\\"
"syn match hp42Special "\v\s_"
"syn match hp42On /\v^\s*on\s(cancel|error|receive)\b/
"syn match hp42On "on receive"
syn match hp42Head /\v\s*[A-Z][A-Z><?]+/
"syn match hp42Head /\v\\\s*[A-Z][A-Z><?]+/
"syn match hp42Head /;\@<=[ ]*[^ ;#\[\]{}()]\+/
"syn match hp42Key /\v\zs[^' ]+\ze[ ]*:/
"syn keyword hp42Key if unless

syn region hp42String start=+"+  skip=+\\"+  end=+"+
syn region hp42Comment start=";" end="\n"

hi def link hp42Head Keyword
hi def link hp42String String
hi def link hp42Comment Comment
hi def link hp42Special Special
"hi def link hp42Key Keyword
"hi def link hp42On Keyword

let b:current_syntax = "hp42"

