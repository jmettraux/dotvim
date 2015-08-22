
" MIT license

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

"syn case match

"syn keyword flTodo TODO
"hi def link flTodo Todo

"syn match flBinaryFilename '^Binary file .\+ matches'
"hi def link flBinaryFilename Special
"syn match flBf '^Binary file'
"hi def link flBinaryFilename Normal

syn match flTitle '^== .\+'

syn match flFilename '^[^ :]\+:'
"hi def link flFilename flFilename

"hi! flFilename cterm=NONE ctermfg=33 ctermbg=16 " black #18D875

syn match flLineNr '\d\+:'
"hi def link flLineNr LineNr

let b:current_syntax = "filelist"

