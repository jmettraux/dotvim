
" MIT license

hi! rsoFilename cterm=NONE ctermfg=darkgreen ctermbg=16
hi! rsoFail cterm=NONE ctermfg=darkred ctermbg=16
hi! rsoPending cterm=NONE ctermfg=yellow ctermbg=16

syn match rsoFilename '\.\/[^:]\+:[0-9]\+'
syn match rsoPending 'Pending:'
syn match rsoFail 'Failures:'
"syn match rsoFail 'Errors\?'

let b:current_syntax = "rspecout"

