
" MIT licensed

"hi! gsdAts cterm=NONE ctermfg=lightgrey ctermbg=darkgrey
hi! gsdLineMinus cterm=NONE ctermfg=lightgrey ctermbg=red
hi! gsdLinePlus cterm=NONE ctermfg=black ctermbg=darkgreen
hi! gsdLineNumber cterm=NONE ctermfg=238 ctermbg=black
hi! gitSingleDiffLine cterm=NONE ctermfg=238 ctermbg=black

syn match gsdLinePlus /\v^ *\d+ \+.+$/ contains=gsdLineNumber
syn match gsdLineMinus /\v^ *\d+ -.+$/ contains=gsdLineNumber
syn match gsdLineNumber /\v^ *\d+/ contained

highlight ColorColumn ctermbg=16
  " disable > 80 column highlight

