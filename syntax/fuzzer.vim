
" (<pat>)@<=<match>               ~~~ positive lookbehind
"           <match>(<pattern>)@=  ~~~ positive lookahead
"   (<pat)@!<match>               ~~~ negative lookbehind
"           <match>(<pat>)@!      ~~~ negative lookahead

hi! fuzFileName cterm=NONE ctermfg=darkyellow ctermbg=16
hi! fuzSlash cterm=NONE ctermfg=darkgrey ctermbg=16
hi! fuzDot cterm=NONE ctermfg=darkgrey ctermbg=16
hi! fuzExt cterm=NONE ctermfg=green ctermbg=16
hi! fuzSize cterm=bold ctermfg=238 ctermbg=16
hi! fuzLines cterm=NONE ctermfg=darkgrey ctermbg=16
hi! fuzDir cterm=NONE ctermfg=darkgreen ctermbg=16
hi! fuzGit cterm=NONE ctermfg=white ctermbg=16
hi! fuzExt cterm=NONE ctermfg=grey ctermbg=16
hi! fuzAge cterm=NONE ctermfg=238 ctermbg=16

syn match fuzFileName '\v .+$' contains=fuzDir,fuzSlash,fuzDot,fuzExt,fuzSize,fuzLines,fuzGit,fuzAge

syn match fuzSize '\v [0-9]+[PTMKB]' contained
syn match fuzLines '\v [0-9]+L' contained
syn match fuzGit '\v\+[0-9]+\-[0-9]+' contained
syn match fuzAge '\v ([0-9]+[dhms])+' contained

syn match fuzDir '\v[^\/]+(\/)@=' contained
"syn match fuzExt '\v\.[^.]+( [0-9])@=' contained
syn match fuzExt '\v([a-zA-Z0-9]\.)@<=[a-zA-Z]+( [0-9])@=' contained
syn match fuzSlash '/' contained
syn match fuzDot '\v\.' contained

let b:current_syntax = "fuzzer"

