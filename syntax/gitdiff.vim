
" MIT licensed

hi! gdiCommit cterm=NONE ctermfg=136 ctermbg=16

hi! gdiFilename cterm=NONE ctermfg=white ctermbg=16
hi! gdiDiffMinus cterm=NONE ctermfg=red ctermbg=16
hi! gdiDiffPlus cterm=NONE ctermfg=green ctermbg=16

syn match gdiCommit /\v^commit [a-fA-F0-9]+/
syn match gdiCommit /\v^Author: .+/
syn match gdiCommit /\v^Date: .+/

syn match gdiFilename /^[^:]\+:[0-9]\+ ---+++/

syn region gdiDiffPlus start=/^+/ end="\n"
syn region gdiDiffMinus start=/^-/ end="\n"

highlight ColorColumn ctermbg=16
  " disable > 80 column highlight

let b:current_syntax = "gitdiff"

