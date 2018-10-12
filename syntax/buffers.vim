
" MIT licensed

hi! bufTitle cterm=NONE ctermfg=grey ctermbg=16
hi! bufDirName cterm=NONE ctermfg=darkgreen ctermbg=16
hi! bufFileName cterm=NONE ctermfg=green ctermbg=16
hi! bufLineNumber cterm=NONE ctermfg=darkgrey ctermbg=16
hi! bufTreeDir cterm=NONE ctermfg=darkgreen ctermbg=16
hi! bufTreeFile cterm=NONE ctermfg=green ctermbg=16
hi def link bufComment Comment
hi def link bufTree Comment

hi! bufVimGrep cterm=NONE ctermfg=darkgray ctermbg=16
hi! bufVgRex cterm=NONE ctermfg=darkgray ctermbg=16
hi! bufVgRx cterm=NONE ctermfg=136 ctermbg=16
hi def link bufVgDir bufTreeDir

syn match bufTitle '^== .\+'

syn match bufDirName    '\v[/~]?[-A-Za-z0-9 \(\)_.]+/' contained
syn match bufFileName   '\v[/~]?[-A-Za-z0-9 \(\)_.]+(:| +\||$)@=' contained
syn match bufLineNumber '\v:[0-9]+(\s+[0-9]+)$' contained
  "
  " @= is positive lookahead...

syn match bufPath   '\v^[/~]?[-A-Za-z0-9 \(\)_./]+(:[0-9]+)?(\s+[0-9]+)?$' contains=bufFileName,bufDirName,bufLineNumber
syn match bufStatus '\v^[-A-Za-z0-9 \(\)_./]+ +\|' contains=bufFileName,bufDirName

syn match bufTree     '\v^[├│└─  ]+' contained
syn match bufTreeDir  '\v[-A-Za-z0-9 \(\)_.]+\/' contained
syn match bufTreeFile '\v[-A-Za-z0-9 \(\)_.]+$' contained
syn match bufTreeLine '\v^[├│└─  ]+ [^:]+$' contains=bufTree,bufTreeDir,bufTreeFile

syn match bufVimGrep '\v  \/ "[^"]+" +(.+)$' contains=bufVgRex,bufVgDir
syn match bufVimGrep '\v  \/ \'[^\']+\' +(.+)$' contains=bufVgRex,bufVgDir
syn match bufVgRex '\v"[^"]+"' contained contains=bufVgRx
syn match bufVgRex '\v\'[^\']+\'' contained contains=bufVgRx
syn match bufVgRx '\v[^\'"]+' contained
syn match bufVgDir '\v[^ ]+$' contained

syn region bufComment start="#" end="\n"
"syn region bufComment start="(" end="\n"
syn region bufComment start="|" end="\n"

let b:current_syntax = "buffers"

