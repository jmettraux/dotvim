
" MIT licensed

  " (<pattern>)@<=<match>  ~~~ positive lookbehind
  " <match>(<pattern>)@=   ~~~ positive lookahead
  " (<pattern>)@!<match>   ~~~ negative lookbehind
  " <match>(<pattern>)@!   ~~~ negative lookahead

hi! zapFileName cterm=NONE ctermfg=darkyellow ctermbg=16
hi! zapSlash cterm=NONE ctermfg=darkgrey ctermbg=16
hi! zapDot cterm=NONE ctermfg=darkgrey ctermbg=16
hi! zapColon cterm=NONE ctermfg=darkgrey ctermbg=16
hi! zapExt cterm=NONE ctermfg=green ctermbg=16
hi! zapDir cterm=NONE ctermfg=darkgreen ctermbg=16
hi! zapNumber cterm=NONE ctermfg=darkgrey ctermbg=16

syn match zapFileName '\v^ *[^:]+:[0-9]+ ' contains=zapSlash,zapDot,zapExt,zapColon,zapNumber,zapDir
"
"syn match fuzSize '\v [0-9]+[PTMKB]' contained
"syn match fuzLines '\v [0-9]+L' contained
"syn match fuzGit '\v\+[0-9]+\-[0-9]+' contained
"
"syn match fuzDir '\v[^\/]+(\/)@=' contained
""syn match fuzExt '\v\.[^.]+( [0-9])@=' contained
"syn match fuzExt '\v([a-zA-Z0-9]\.)@<=[a-zA-Z]+( [0-9])@=' contained
syn match zapExt '\v(\.)@<=[^:.]+(:[0-9]+ )@=' contained
syn match zapSlash '/' contained
syn match zapDot '\v\.' contained
syn match zapColon ':' contained
syn match zapDir '\v[^\/]+(\/)@=' contained
syn match zapNumber '\v(:)@<=[0-9]+' contained

let b:current_syntax = "zapicat"

