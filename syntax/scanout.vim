
" MIT licensed

hi! scoTitle cterm=NONE ctermfg=darkyellow ctermbg=16
hi! scoLine cterm=NONE ctermfg=darkgreen ctermbg=16
hi! scoFuncName cterm=NONE ctermfg=white ctermbg=16
hi! scoSpecKeyword cterm=NONE ctermfg=white ctermbg=16
hi! scoAttr cterm=NONE ctermfg=white ctermbg=16
hi! scoKeyword cterm=NONE ctermfg=darkyellow ctermbg=16
hi def link scoString String
"hi def link scoString Comment
hi def link scoComment Comment

syn match scoTitle '^== .\+'
syn match scoLine /\v^\s*\d+/
syn region scoString start=+"+ skip=+\\"+ end=+"+ oneline
syn region scoString start=+'+ skip=+\\'+ end=+'+ oneline

" Ruby
syn keyword scoKeyword class module public protected private include extends
syn region scoFuncName matchgroup=scoX start=/\v(^|\s+)def(\s+self\.|\s+)/ matchgroup=scoX end=/\v\s*(\(|\\|;|$)/
syn region scoFuncName matchgroup=scoX start=/\v(^|\s+)alias(\s+)/ matchgroup=scoX end=/\v\s+/
syn match scoAttr '\(:\)\@<=[^ ,]\+' contained
syn match scoAttrs '\v\s*attr_(reader|writer|accessor)\s+.+$' contains=scoAttr

" Javascript
syn region scoFuncName matchgroup=scoX start=/\v(^|\s+)var\s+/ matchgroup=scoX end=/\v\s*\=\s*\(?function/
syn region scoFuncName matchgroup=scoX start=/\v(^|\s+)this\./ matchgroup=scoX end=/\v\s*\=\s*function/

" Rspec
syn keyword scoSpecKeyword describe context
"syn keyword scoSpecKeyword context

" VB
syn keyword scoKeyword Option Public Sub Function Optional ByVal ByRef As
"syn region scoComment start=+'+  skip=+\\'+  end=+\v[\n\r]+

let b:current_syntax = "scanout"

