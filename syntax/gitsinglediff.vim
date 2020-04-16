
" MIT licensed

hi! gsdAts cterm=NONE ctermfg=lightgrey ctermbg=darkgrey
hi! gsdMinus cterm=NONE ctermfg=lightgrey ctermbg=red
hi! gsdPlus cterm=NONE ctermfg=black ctermbg=darkgreen

"syn region gsdAts start="\v^[@]" end="\v [@]"
syn region gsdPlus start=/^+/ end="\n"
syn region gsdMinus start=/^-/ end="\n"

"highlight ColorColumn ctermbg=16
  " disable > 80 column highlight

