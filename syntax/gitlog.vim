
" MIT licensed

hi! gilSha cterm=NONE ctermfg=136 ctermbg=16
hi! gilTags cterm=NONE ctermfg=darkgreen ctermbg=16
hi! gilTree cterm=NONE ctermfg=grey ctermbg=16

syn match gilTree /\v^[*|\\\/ ]+/
syn match gilTree /\v^[*| ]+/ contained
syn match gilSha /\v^[*| ]+[a-fA-F0-9]+ / contains=gilTree
syn match gilTags /\v\([^)]+\) /

highlight ColorColumn ctermbg=16
  " disable > 80 column highlight

let b:current_syntax = "gitlog"

