
" MIT licensed

hi! gilSha cterm=NONE ctermfg=136 ctermbg=16
hi! gilTags cterm=NONE ctermfg=darkgreen ctermbg=16

syn match gilSha /\v^* \zs[a-fA-F0-9]+ / " \zs ftw
syn match gilTags /\v\([^)]+\) /

highlight ColorColumn ctermbg=16
  " disable > 80 column highlight

let b:current_syntax = "gitlog"

