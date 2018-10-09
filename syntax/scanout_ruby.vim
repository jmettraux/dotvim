
" MIT licensed

hi! scoTitle cterm=NONE ctermfg=darkyellow ctermbg=16
hi! scoLine cterm=NONE ctermfg=darkgreen ctermbg=16
hi! scoFuncName cterm=NONE ctermfg=white ctermbg=16
hi! scoAttr cterm=NONE ctermfg=white ctermbg=16
hi! scoKeyword cterm=NONE ctermfg=darkyellow ctermbg=16
hi! scoSpecial cterm=NONE ctermfg=black ctermbg=yellow
hi def link scoString String
hi def link scoComment Comment

syn match scoTitle '^== .\+'
syn match scoLine /\v^\s*\d+/
syn region scoString start=+"+ skip=+\\"+ end=+"+
syn region scoString start=+'+ skip=+\\'+ end=+'+
syn region scoComment start=+#+ end=+$+ contains=scoSpecial

" Ruby
syn keyword scoKeyword class module public protected private include extends
syn keyword scoSpecial TODO FIXME contained
syn region scoFuncName matchgroup=scoX start=/\v(^|\s+)def(\s+self\.|\s+)/ matchgroup=scoX end=/\v\s*(\(|\\|;|$)/
syn region scoFuncName matchgroup=scoX start=/\v(^|\s+)alias(\s+)/ matchgroup=scoX end=/\v\s+/
syn match scoAttr '\(:\)\@<=[^ ,]\+' contained
syn match scoAttrs '\v\s*attr_(reader|writer|accessor)\s+.+$' contains=scoAttr


let b:current_syntax = "scanout_ruby"

