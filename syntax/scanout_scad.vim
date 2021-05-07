
" MIT licensed

hi! scoTitle cterm=NONE ctermfg=darkyellow ctermbg=16
hi! scoLine cterm=NONE ctermfg=darkgrey ctermbg=16
hi! scoName cterm=NONE ctermfg=white ctermbg=16
hi! scoVarName cterm=NONE ctermfg=white ctermbg=16
"hi! scoAttr cterm=NONE ctermfg=white ctermbg=16
hi! scoKeyword cterm=NONE ctermfg=darkyellow ctermbg=16
"hi! scoSpecial cterm=NONE ctermfg=black ctermbg=yellow
"hi! scoRex cterm=NONE ctermfg=red ctermbg=16
hi def link scoString String
hi def link scoComment Comment


"
" OpenSCAD

syn match scoKeyword '\v(function|module)' contained
syn match scoLine '\v^ *[0-9]+ .*$' contains=scoLineNumber,scoFunction,scoComment,scoVarName
syn match scoLineNumber '\v^ *[0-9]+' contained
"syn match scoVar '\v\s*var\s+[^ 	]+\s*\=' contained contains=scoName
"syn match scoThis '\v\s*this\.[^ 	]+' contained contains=scoName
syn match scoFunction '\v\s*(function\s+|module\s+)[^ 	(]+' contained contains=scoKeyword,scoName
syn match scoName '\v(function\s+|module\s+)@<=[^ 	(]+' contained
syn match scoComment '\v\/\/[^$]*' contained contains=scoSpecial
syn match scoSpecial '\v(TODO|FIXME)' contained
syn match scoVarName '\v( [0-9]+ )@<=[a-z][a-z_0-9A-Z]+' contained


let b:current_syntax = "scanout_scad"

