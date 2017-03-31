
" MIT license

"hi! rsoFilename cterm=NONE ctermfg=darkgreen ctermbg=16
hi! rsoLocalFilename cterm=NONE ctermfg=blue ctermbg=16
hi! rsoFilename cterm=NONE ctermfg=darkgreen ctermbg=16
hi! rsoFail cterm=NONE ctermfg=darkred ctermbg=16
hi! rsoPending cterm=NONE ctermfg=yellow ctermbg=16
hi! rsoDiffMinus cterm=NONE ctermfg=red ctermbg=16
hi! rsoDiffPlus cterm=NONE ctermfg=green ctermbg=16

syn match rsoLocalFilename ' \.\/[^:]\+:[0-9]\+'
syn match rsoFilename ' \/[^:]\+:[0-9]\+'
syn match rsoPending 'Pending:'
syn match rsoFail 'Failures:'
"syn match rsoFail 'Errors\?'

syn match rsoDiffMinus '^ \+-.*$'
syn match rsoDiffPlus '^ \++.*$'

let b:current_syntax = "rspecout"

