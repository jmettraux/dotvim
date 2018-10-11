
" MIT licensed

hi! groTitle cterm=NONE ctermfg=darkyellow ctermbg=16
hi! groFilename cterm=NONE ctermfg=blue ctermbg=16
hi! groLineNr cterm=NONE ctermfg=darkgreen ctermbg=16
hi! groPipe cterm=NONE ctermfg=darkblue ctermbg=16
hi! groPattern cterm=NONE ctermfg=darkgreen ctermbg=16
hi! groError cterm=NONE ctermfg=darkred ctermbg=16

highlight ColorColumn ctermbg=16
  " disable > 80 column highlight

syn match groTitle '^== .\+'
syn match groFilename '^[^ :=]\+'
syn match groLineNr '\v^ +\d+\|' contains=groPipe
syn match groPipe '\v\|' contained
syn match groError '\v^grep\.py choked .+$'

exe "syn match groPattern " . g:groPattern

let b:current_syntax = "greprout"

