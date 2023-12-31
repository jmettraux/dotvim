
" (<pat>)@<=<match>               ~~~ positive lookbehind
"           <match>(<pattern>)@=  ~~~ positive lookahead
"   (<pat)@!<match>               ~~~ negative lookbehind
"           <match>(<pat>)@!      ~~~ negative lookahead


hi! gdiCommit cterm=NONE ctermfg=white ctermbg=darkgrey

hi! gdiFilename cterm=bold ctermfg=black ctermbg=136
hi! gdiDiffMinus cterm=NONE ctermfg=darkred ctermbg=16
hi! gdiDiffPlus cterm=NONE ctermfg=green ctermbg=16
hi! gitPlus cterm=NONE ctermfg=black ctermbg=green
hi! gitMinus cterm=NONE ctermfg=darkgrey ctermbg=darkgrey

syn match gdiCommit /\v^(Commit|Author|Date): .+/

syn match gdiFilename /\v^[^:]+:[0-9]+ ---\+\+\+ .+\.$/

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


let b:current_syntax = "gitdiff"

