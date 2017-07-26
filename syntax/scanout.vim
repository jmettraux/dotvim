
" MIT licensed

hi! scoTitle cterm=NONE ctermfg=darkyellow ctermbg=16
hi! scoLine cterm=NONE ctermfg=darkgreen ctermbg=16

syn match scoTitle '^== .\+'
syn match scoLine /\v^\s*\d+/

let b:current_syntax = "scanout"

