
" MIT licensed

hi! gdiCommit cterm=NONE ctermfg=136 ctermbg=16

"hi! gdiFilename cterm=NONE ctermfg=black ctermbg=lightgrey
hi! gdiFilename cterm=NONE ctermfg=darkblue ctermbg=lightgrey
hi! gdiDiffMinus cterm=NONE ctermfg=red ctermbg=16
hi! gdiDiffPlus cterm=NONE ctermfg=green ctermbg=16

syn match gdiCommit /\v^commit [a-fA-F0-9]+/
syn match gdiCommit /\v^Author: .+/
syn match gdiCommit /\v^Date: .+/

syn match gdiFilename /^[^:]\+:[0-9]\+ ---+++/

syn region gdiDiffPlus start=/^+/ end="\n"
syn region gdiDiffMinus start=/^-/ end="\n"

hi! gdiStatFilename cterm=NONE ctermfg=darkblue ctermbg=lightgrey
hi! gdiStatFilei cterm=NONE ctermfg=white ctermbg=16
hi! gdiStatFileplus cterm=NONE ctermfg=green ctermbg=16
hi! gdiStatFileminus cterm=NONE ctermfg=red ctermbg=16
hi! gdiStatFilechanged cterm=NONE ctermfg=white ctermbg=16
hi! gdiStatInsertions cterm=NONE ctermfg=green ctermbg=16
hi! gdiStatDeletions cterm=NONE ctermfg=red ctermbg=16

syn match gdiStatFilename /\v^[^ ]+/ contained
syn match gdiStatFilei /\v [0-9]+ / contained
syn match gdiStatFileplus /\v\+/ contained
syn match gdiStatFileminus /\v\-/ contained
syn match gdiStatFileline /\v^[^ ]+ +\| +[0-9]+ \+*-*$/ contains=gdiStatFilename,gdiStatFilei,gdiStatFileplus,gdiStatFileminus
syn match gdiStatFilechanged /\v^ [0-9]+ file changed/
syn match gdiStatInsertions /\v [0-9]+ insertions\(\+\)/
syn match gdiStatDeletions /\v [0-9]+ deletions\(\-\)/

highlight ColorColumn ctermbg=16
  " disable > 80 column highlight

let b:current_syntax = "gitdiff"

