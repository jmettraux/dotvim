
" MIT licensed

hi! scoTitle cterm=NONE ctermfg=darkyellow ctermbg=16
hi! scoLine cterm=NONE ctermfg=darkgreen ctermbg=16
hi! scoFuncName cterm=NONE ctermfg=white ctermbg=16

syn match scoTitle '^== .\+'
syn match scoLine /\v^\s*\d+/

syn region scoFuncName matchgroup=scoX start=/\v(^|\s+)var\s+/ matchgroup=scoX end=/\v\s*\=\s*\(?function/
syn region scoFuncName matchgroup=scoX start=/\v(^|\s+)this\./ matchgroup=scoX end=/\v\s*\=\s*function/

let b:current_syntax = "scanout"

