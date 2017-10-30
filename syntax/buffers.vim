
" MIT licensed

hi! bufTitle cterm=NONE ctermfg=grey ctermbg=16
hi! bufPath cterm=NONE ctermfg=darkgreen ctermbg=16
hi! bufFilename cterm=NONE ctermfg=green ctermbg=16
hi! bufTreeDir cterm=NONE ctermfg=darkgreen ctermbg=16
hi! bufTreeFile cterm=NONE ctermfg=green ctermbg=16
hi def link bufComment Comment
hi def link bufTree Comment

syn match bufTitle '^== .\+'

syn match bufPath '\v^/?([^=# /]+/)+'
syn match bufFilename '\v/@<=[^ ]+'
syn match bufFilename '\v^[^= /├│]+( |$)'

syn match bufTree '\v^[└├│─ ]+' contained
syn match bufTreeDir '\v[^└├│─ ]+$' contained
syn match bufTreeFile '\v[^└├│─ /]+$' contained
syn match bufTreeLine '\v^[└├│─ ]+.+$' contains=bufTree,bufTreeDir,bufTreeFile

syn region bufComment start="#" end="\n"
syn region bufComment start="(" end="\n"
syn region bufComment start="|" end="\n"

let b:current_syntax = "buffers"

