
" MIT licensed

"hi! bufDirName cterm=NONE ctermfg=darkgreen ctermbg=16
"hi! bufFileName cterm=NONE ctermfg=green ctermbg=16
"hi! bufLineNumber cterm=NONE ctermfg=darkgrey ctermbg=16
"hi! bufTreeDir cterm=NONE ctermfg=darkgreen ctermbg=16
"hi! bufTreeFile cterm=NONE ctermfg=green ctermbg=16
"hi def link bufTree Comment
"
"hi! bufVgRex cterm=NONE ctermfg=darkgray ctermbg=16
"hi! bufVgRx cterm=NONE ctermfg=136 ctermbg=16
"hi def link bufVgDir bufTreeDir
hi! bufDir cterm=NONE ctermfg=darkgreen ctermbg=16
hi! bufPath cterm=NONE ctermfg=136 ctermbg=16
hi! bufFilename cterm=NONE ctermfg=green ctermbg=16
hi def link bufLinePath bufPath
  "
hi! bufLineTitle cterm=NONE ctermfg=grey ctermbg=16
hi! bufLine cterm=NONE ctermfg=green ctermbg=16
hi! bufLineGrep cterm=NONE ctermfg=blue ctermbg=16
hi def link bufLineComment Comment
hi def link bufEolComment Comment
hi! bufLineGrep cterm=NONE ctermfg=darkgray ctermbg=16
hi! bufLgRx cterm=NONE ctermfg=136 ctermbg=16
hi! bufLgiStatus cterm=NONE ctermfg=darkgray ctermbg=16
hi! bufLineAndRegister cterm=NONE ctermfg=darkgray ctermbg=16
hi def link bufLgDir bufDir
hi def link bufComment Comment
hi def link bufSize Comment

syn match bufLineTitle '\v^\=\= .+'
syn match bufLineGrep '\v^  \/ .*$' contains=bufLgRex,bufLgDir
syn match bufLineComment '\v^[ 	]*#.*$'
syn match bufEolComment '\v#.*$'
syn match bufLineGit '\v^[^ 	][^|]+ \| .*$' contains=bufPath,bufLgiStatus
syn match bufLinePath '\v^[^ #=][^|]+$' contains=bufFilename

syn match bufSize '\v ([0-9]+\.)?[0-9]+[BKMGTPE]$' contained
syn match bufLineAndRegister '\v:[0-9]+( +[0-9]+)?' contained

syn match bufLgiStatus '\v\|[^|]+$' contained
syn match bufFilename '\v(^|\/)@<=[^|]+$' contained contains=bufLineAndRegister,bufSize,bufEolComment
syn match bufPath '\v[^|]+' contained contains=bufFilename

syn match bufLgRx '\v(\/ ")@<=[^"]+' contained
syn match bufLgRx '\v(\/ \')@<=[^\']+' contained
syn match bufLgRex '\v\/ "[^"]+" ' contained contains=bufLgRx
syn match bufLgRex '\v\/ \'[^\']+\' ' contained contains=bufLgRx
syn match bufLgDir '\v(["\'][ 	]+)@<=.+$' contained

"syn match bufFileName   '\v[/~]?[-A-Za-z0-9 \(\)_.]+(:| +\||$)@=' contained
"  " @= is positive lookahead...
"
"syn region bufComment start="#" end="\n"
""syn region bufComment start="(" end="\n"
"syn region bufComment start="|" end="\n"

let b:current_syntax = "buffers"

