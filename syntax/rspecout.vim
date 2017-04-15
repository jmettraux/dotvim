
" MIT licensed

hi! rsoLocalFilename cterm=NONE ctermfg=green ctermbg=16
hi! rsoFilename cterm=NONE ctermfg=darkgreen ctermbg=16
hi! rsoFail cterm=NONE ctermfg=darkred ctermbg=16
hi! rsoPending cterm=NONE ctermfg=yellow ctermbg=16
hi! rsoDiffMinus cterm=NONE ctermfg=red ctermbg=16
hi! rsoDiffPlus cterm=NONE ctermfg=green ctermbg=16
hi! rsoSummary cterm=NONE ctermfg=yellow ctermbg=16
hi! rsoExample cterm=NONE ctermfg=yellow ctermbg=16

highlight ColorColumn ctermbg=16
  " disable > 80 column highlight

syn match rsoLocalFilename ' \.\/[^:]\+:[0-9]\+'
syn match rsoFilename ' \/[^:]\+:[0-9]\+'
syn match rsoPending 'Pending:'
syn match rsoFail 'Failures:'
syn match rsoFail 'Failed examples:'
syn match rsoSummary '^Finished in \d.\+'
syn match rsoSummary '^\d\+ examples,.\+'
syn match rsoExample '^  \d\+) .\+'

syn match rsoDiffMinus '^ \+-.*$'
syn match rsoDiffPlus '^ \++.*$'

let b:current_syntax = "rspecout"

