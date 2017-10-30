
" MIT licensed

hi! lifTitle cterm=NONE ctermfg=grey ctermbg=16
hi! lifPath cterm=NONE ctermfg=darkgreen ctermbg=16
hi! lifFilename cterm=NONE ctermfg=green ctermbg=16
hi! lifTreeDir cterm=NONE ctermfg=darkgreen ctermbg=16
hi! lifTreeFile cterm=NONE ctermfg=green ctermbg=16
hi def link lifComment Comment
hi def link lifTree Comment

syn match lifTitle '^== .\+'

syn match lifPath '\v^/?([^=# /]+/)+'
syn match lifFilename '\v/@<=[^ ]+'
syn match lifFilename '\v^[^= /├│]+( |$)'

syn match lifTree '\v^[├│─ ]+' contained
syn match lifTreeDir '\v[^├│─ ]+$' contained
syn match lifTreeFile '\v[^├│─ /]+$' contained
syn match lifTreeLine '\v^[├│─ ]+.+$' contains=lifTree,lifTreeDir,lifTreeFile

syn region lifComment start="#" end="\n"
syn region lifComment start="(" end="\n"
syn region lifComment start="|" end="\n"

let b:current_syntax = "listfiles"

