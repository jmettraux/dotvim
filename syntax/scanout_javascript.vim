
" MIT licensed

hi! scoTitle cterm=NONE ctermfg=darkyellow ctermbg=16
hi! scoLineNumber cterm=NONE ctermfg=darkgreen ctermbg=16
hi! scoName cterm=NONE ctermfg=white ctermbg=16
hi! scoName cterm=NONE ctermfg=white ctermbg=16
hi! scoSpecial cterm=NONE ctermfg=black ctermbg=yellow
hi def link scoComment Comment
hi def link scoMemberName scoName
hi def link scoGetterName scoName

syn match scoTitle '^== .\+'

"
" javascript

syn match scoLine '\v^ *[0-9]+ .*$' contains=scoLineNumber,scoVar,scoThis,scoFunction,scoComment,scoMemberName,scoGetter
syn match scoLineNumber '\v^ *[0-9]+' contained
syn match scoVar '\v\s*var\s+[^ 	]+\s*\=' contained contains=scoName
syn match scoThis '\v\s*this\.[^ 	]+' contained contains=scoName
syn match scoFunction '\v\s*function\s+[^ 	(]+' contained contains=scoName
syn match scoName '\v(var\s+|this\.|function\s+)@<=[^ 	(#]+' contained
syn match scoComment '\v\/\/[^$]*' contained contains=scoSpecial
syn match scoSpecial '\v(TODO|FIXME)' contained

syn match scoMemberName '\v([^,]+)@<= +#?[a-z_][a-zA-Z0-9_]+' contained

syn match scoGetter '\v +(get|set)\s+#?[a-z_][a-zA-Z0-9_]+' contained contains=scoGetterName
syn match scoGetterName '\v(get\s+|set\s+)@<=[^ 	(#]+' contained


let b:current_syntax = "scanout_javascript"

