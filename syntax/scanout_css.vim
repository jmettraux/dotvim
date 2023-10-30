
" MIT licensed

hi! scoTitle cterm=NONE ctermfg=darkyellow ctermbg=16
hi! scoLineNumber cterm=NONE ctermfg=green ctermbg=16

hi! scoSelector cterm=NONE ctermfg=yellow ctermbg=16
hi! scoSelTag cterm=NONE ctermfg=darkblue ctermbg=16
hi! scoSelId cterm=NONE ctermfg=red ctermbg=16
hi! scoSelCla cterm=NONE ctermfg=darkgreen ctermbg=16
hi! scoSelAtt cterm=NONE ctermfg=white ctermbg=16

hi! scoBlock cterm=NONE ctermfg=darkgray ctermbg=16


"
" CSS

syn match scoTitle '^== .\+$'
syn match scoLine '\v^ *[0-9]+ .*$' contains=scoLineNumber,scoLine

syn match scoLine '\v +.+$' contains=scoSelector,scoBlock contained
syn match scoLineNumber '\v^ *[0-9]+' contained
syn match scoSelector '\v\s*[^{]+' contains=scoSelTag,scoSelId,scoSelCla,scoSelAtt contained
syn match scoSelTag '\v\s*[^#.[{]+' contained
syn match scoSelId '\v#[^#.[{]+' contained
syn match scoSelCla '\v\.[^#.[{]+' contained
syn match scoSelAtt '\v\[[^\]]+\]' contained
syn match scoBlock '\v\{.*$' contained

let b:current_syntax = "scanout_css"

