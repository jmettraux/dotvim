
" MIT licensed

  " (<pattern>)@<=<match>  ~~~ positive lookbehind
  " <match>(<pattern>)@=   ~~~ positive lookahead
  " (<pattern>)@!<match>   ~~~ negative lookbehind
  " <match>(<pattern>)@!   ~~~ negative lookahead

hi! cdsTitle cterm=NONE ctermfg=lightgrey ctermbg=16
hi! cdsPath cterm=NONE ctermfg=darkgreen ctermbg=16
hi! cdsFileName cterm=NONE ctermfg=darkyellow ctermbg=16
hi! cdsLineNumber cterm=NONE ctermfg=darkgrey ctermbg=16
hi! cdsBad cterm=NONE ctermfg=red ctermbg=16
hi! cdsArrow cterm=NONE ctermfg=darkgrey ctermbg=16
hi! cdsGoodElt cterm=NONE ctermfg=green ctermbg=16

syn match cdsTitle '\v^\=\= codespell'
syn match cdsLine '\v[^ =].+' contains=cdsPath,cdsBad,cdsArrow,cdsGood
syn match cdsArrow '⟶' contained
syn match cdsGood '\v( ⟶ )@<=.+' contained contains=cdsGoodElt
syn match cdsGoodElt '\v[^ ,]+' contained
syn match cdsBad '\v .+( ⟶ )@=' contained
syn match cdsPath '\v^.+:\d+(  )@=' contained contains=cdsFileName,cdsLineNumber
syn match cdsFileName '\v(\/)@<=[^\/:]+(:)@=' contained
syn match cdsLineNumber '\v(:)@<=\d+' contained

let b:current_syntax = "codespell"

