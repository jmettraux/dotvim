
" MIT licensed


"hi! gdiCommit cterm=NONE ctermfg=136 ctermbg=16
hi! gdiCommit cterm=NONE ctermfg=white ctermbg=darkgrey

"hi! gdiFilename cterm=NONE ctermfg=black ctermbg=lightgrey
hi! gdiFilename cterm=NONE ctermfg=white ctermbg=darkgrey
hi! gdiDiffMinus cterm=NONE ctermfg=red ctermbg=16
hi! gdiDiffPlus cterm=NONE ctermfg=green ctermbg=16
hi! gitPlus cterm=NONE ctermfg=darkgrey ctermbg=16
hi! gitMinus cterm=NONE ctermfg=darkgrey ctermbg=16

syn match gdiCommit /\v^commit [a-fA-F0-9]+ .+/
syn match gdiCommit /\v^(Author|Date): .+/

syn match gdiFilename /\v^[^:]+:[0-9]+ ---\+\+\+\s*\.$/

syn region gdiDiffPlus start=/^+/ end="\n" contains=gitPlus
syn region gdiDiffMinus start=/^-/ end="\n" contains=gitMinus

"hi! gdiStatFileName cterm=NONE ctermfg=black ctermbg=lightgrey
"hi! gdiStatFileName cterm=NONE ctermfg=136 ctermbg=16
hi! gdiStatFileName cterm=NONE ctermfg=lightgrey ctermbg=16
hi! gdiStatFilePlus cterm=NONE ctermfg=green ctermbg=16
hi! gdiStatFileMinus cterm=NONE ctermfg=red ctermbg=16

syn match gdiStatFileMinus /\v-[0-9]+/ contained
syn match gdiStatFilePlus /\v\+[0-9]+/ contained
syn match gdiStatFileName /\v^[^|]+/ contained
syn match gitStatFileStatus /\v[MDAR]/ contained
syn match gdiStatFileLine /\v^[^|]+\s+\| [MDAR]\+[0-9]+-[0-9]+$/ contains=gdiStatFilename,gdiStatFileStatus,gdiStatFileMinus,gdiStatFileplus

syn match gitPlus '\v^\+' contained
syn match gitMinus '\v^\-' contained

highlight ColorColumn ctermbg=16
  " disable > 80 column highlight


let b:current_syntax = "gitdiff"

