
" MIT licensed

  " (<pattern>)@<=<match>  ~~~ positive lookbehind
  " <match>(<pattern>)@=   ~~~ positive lookahead
  " (<pattern>)@!<match>   ~~~ negative lookbehind
  " <match>(<pattern>)@!   ~~~ negative lookahead

highlight ColorColumn ctermbg=16
  " disable > 80 column highlight

hi! zapFileName cterm=NONE ctermfg=darkyellow ctermbg=16
hi! zapSlash cterm=NONE ctermfg=darkgrey ctermbg=16
hi! zapDot cterm=NONE ctermfg=darkgrey ctermbg=16
hi! zapColon cterm=NONE ctermfg=darkgrey ctermbg=16
hi! zapExt cterm=NONE ctermfg=green ctermbg=16
hi! zapDir cterm=NONE ctermfg=darkgreen ctermbg=16
hi! zapNumber cterm=NONE ctermfg=darkgrey ctermbg=16
hi! zapTail cterm=NONE ctermfg=darkred ctermbg=16
hi! zapType cterm=NONE ctermfg=green ctermbg=16
hi! zapLine cterm=NONE ctermfg=grey ctermbg=16
hi! zapDef cterm=NONE ctermfg=white ctermbg=16
hi! zapMod cterm=NONE ctermfg=white ctermbg=16
hi! zapVar cterm=NONE ctermfg=white ctermbg=16

syn match zapFileName '\v^ *[^:]+:[0-9]+ ' contains=zapSlash,zapDot,zapExt,zapColon,zapNumber,zapDir
syn match zapExt '\v(\.)@<=[^:.]+(:[0-9]+ )@=' contained
syn match zapSlash '/' contained
syn match zapDot '\v\.' contained
syn match zapColon ':' contained
syn match zapDir '\v[^\/:]+(\/)@=' contained
syn match zapNumber '\v(:)@<=[0-9]+ +' contained
syn match zapTail '\v(:[0-9]+ +)@<=(.+)$' contains=zapType,zapLine
syn match zapType '\v(:[0-9]+ +)@<=[a-z]{1} ' contained
syn match zapLine '\v(:[0-9]+ +[a-z]{1} )@<=(.+)$' contained contains=zapMod,zapDef,zapVar
syn match zapDef '\v(def |function)' contained
syn match zapMod '\v(module|class) ' contained
syn match zapVar '\vvar ' contained

let b:current_syntax = "zapicat"

