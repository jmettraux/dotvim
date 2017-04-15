
" MIT licensed

hi! lifTitle cterm=NONE ctermfg=grey ctermbg=16
hi! lifPath cterm=NONE ctermfg=darkgreen ctermbg=16
hi! lifFilename cterm=NONE ctermfg=green ctermbg=16
hi def link lifComment Comment

syn match lifTitle '^== .\+'
syn match lifPath '\v^/?([^=# /]+/)+'
syn match lifFilename '\v/@<=[^ ]+'
syn match lifFilename '\v^[^= /]+( |$)'

"syn region lifFilename start=/[^=#]/ end=/[ \n\(]/
syn region lifComment start="#" end="\n"
syn region lifComment start="(" end="\n"
syn region lifComment start="|" end="\n"

let b:current_syntax = "listfiles"

