
" MIT licensed

hi! scoTitle cterm=NONE ctermfg=darkyellow ctermbg=16
hi! scoLine cterm=NONE ctermfg=darkgreen ctermbg=16
hi! scoFuncName cterm=NONE ctermfg=white ctermbg=16
hi! scoKeyword cterm=NONE ctermfg=darkyellow ctermbg=16
hi def link scoString String
hi def link scoSpecDescribe ScoFuncName

syn match scoTitle '^== .\+'
syn match scoLine /\v^\s*\d+/
syn region scoString start=+"+  skip=+\\"+  end=+"+
syn region scoString start=+'+  skip=+\\'+  end=+'+

" Ruby
syn keyword scoKeyword class
syn keyword scoKeyword module
syn keyword scoKeyword public
syn keyword scoKeyword protected
syn keyword scoKeyword private
syn keyword scoKeyword include
syn keyword scoKeyword extends
syn region scoFuncName matchgroup=scoX start=/\v(^|\s+)def(\s+self\.|\s+)/ matchgroup=scoX end=/\v\s*(\(|$)/

" Javascript
syn region scoFuncName matchgroup=scoX start=/\v(^|\s+)var\s+/ matchgroup=scoX end=/\v\s*\=\s*\(?function/
syn region scoFuncName matchgroup=scoX start=/\v(^|\s+)this\./ matchgroup=scoX end=/\v\s*\=\s*function/

" Rspec
syn keyword scoSpecDescribe describe

let b:current_syntax = "scanout"

