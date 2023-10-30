
" MIT licensed

"hi! scoTitle cterm=NONE ctermfg=white ctermbg=16
hi! scoLineNumber cterm=NONE ctermfg=green ctermbg=16
"hi! scoSelector cterm=NONE ctermfg=yellow ctermbg=16
"hi! scoBracket cterm=NONE ctermfg=darkgray ctermbg=16


"
" CSS

syn match scoLine '\v^ *[0-9]+ .*$' contains=scoLineNumber,scoSelector,scoBracket

syn match scoLineNumber '\v^ *[0-9]+' contained
"syn match scoSelector '\v[^0-9{]+' contained
"syn match scoBracket '\v\{\s*$' contained


let b:current_syntax = "scanout_css"

