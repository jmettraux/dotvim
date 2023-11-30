
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
"hi! bufPath cterm=NONE ctermfg=136 ctermbg=16
hi! bufPath cterm=NONE ctermfg=lightgrey ctermbg=16
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
hi! bufLgiStatusPlus cterm=NONE ctermfg=green ctermbg=16
hi! bufLgiStatusMinus cterm=NONE ctermfg=red ctermbg=16
"hi! bufLgiStatus cterm=NONE ctermfg=blue ctermbg=16
hi! bufLineAndRegister cterm=NONE ctermfg=darkgray ctermbg=16
hi def link bufLgDir bufDir
hi def link bufComment Comment
hi def link bufSize Comment
hi def link bufLines Comment
"hi def link bufGit Comment

syn match bufLineTitle '\v^\=\= .+'
syn match bufLineGrep '\v^  \/ .*$' contains=bufLgRex,bufLgDir
syn match bufLineComment '\v^[ 	]*#.*$'
syn match bufEolComment '\v#.*$'
syn match bufLineGit '\v^[^ 	][^|]+ \| .*$' contains=bufPath,bufLgiStatus
"syn match bufLinePath '\v^[^ #=][^|]+$' contains=bufFilename
syn match bufLinePath '\v^ *[^ #=][^|]+$' contains=bufFilename

syn match bufSize '\v ([0-9]+\.)?[0-9]+[BKMGTPE]' contained
syn match bufLines '\v [0-9]+L' contained
syn match bufGit '\v \+[0-9]+-[0-9]+' contained
syn match bufLineAndRegister '\v:[0-9]+( +[0-9]+)?' contained

syn match bufLgiStatusPlus '\v\+\d+' contained
syn match bufLgiStatusMinus '\v-\d+' contained
syn match bufLgiStatus '\v\| [MDAR]\+\d+-\d+$' contained contains=bufLgiStatusPlus,bufLgiStatusMinus
syn match bufFilename '\v(^|\/)@<=[^|]+$' contained contains=bufLineAndRegister,bufSize,bufLines,bufGit,bufEolComment
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

