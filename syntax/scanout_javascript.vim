
" MIT licensed

hi! scoTitle cterm=NONE ctermfg=darkyellow ctermbg=16
hi! scoLineNumber cterm=NONE ctermfg=darkgreen ctermbg=16
hi! scoName cterm=NONE ctermfg=white ctermbg=16
hi! scoSpecial cterm=NONE ctermfg=black ctermbg=yellow
hi def link scoComment Comment

syn match scoTitle '^== .\+'

"
" javascript

syn match scoLine '\v^ *[0-9]+ .*$' contains=scoLineNumber,scoVar,scoThis,scoComment
syn match scoLineNumber '\v^ *[0-9]+' contained
syn match scoVar '\v\s*var\s+[^ 	]+\s*\=' contained contains=scoName
syn match scoThis '\v\s*this\.[^ 	]+' contained contains=scoName
syn match scoName '\v(var\s+|this\.)@<=[^ 	]+' contained
syn match scoComment '\v\/\/[^$]+' contained contains=scoSpecial
syn match scoSpecial '\v(TODO|FIXME)' contained


let b:current_syntax = "scanout_javascript"

