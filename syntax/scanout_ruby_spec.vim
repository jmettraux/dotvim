
" MIT licensed

hi! scoTitle cterm=NONE ctermfg=darkyellow ctermbg=16
hi! scoLineNumber cterm=NONE ctermfg=darkgreen ctermbg=16
hi! scoName cterm=NONE ctermfg=darkgreen ctermbg=16
hi! scoSymbol cterm=NONE ctermfg=white ctermbg=16
"hi! scoKeyword cterm=NONE ctermfg=darkyellow ctermbg=16
hi def link scoString String
hi def link scoComment Comment
hi def link scoRequire Comment

syn match scoTitle '^== .\+'

"
" Rspec

syn match scoLine '\v^ *[0-9]+ .*$' contains=scoLineNumber,ScoName,scoKeyword,scoString,scoSymbol,scoComment,scoDo
syn match scoKeyword '\v(describe|before|after|context|it|they)' contained
syn region scoString start=+"+ skip=+\\"+ end=+"+ oneline contained
syn region scoString start=+'+ skip=+\\'+ end=+'+ oneline contained
syn match scoName '\v[A-Z][a-zA-Z:]*' contained
syn match scoSymbol '\v:[a-zA-Z0-9_]+' contained
syn region scoComment start='#' end='\v[\n\r]+' contained
syn match scoDo '\v do\s*[\n\r]' contained

syn match scoRequire '\v^ *[0-9]+ \s*require\s*[( ].*$' contains=scoLineNumber

syn match scoLineNumber '\v^ *[0-9]+' contained


let b:current_syntax = "scanout_ruby_spec"

