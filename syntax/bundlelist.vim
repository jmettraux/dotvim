
" MIT licensed

hi! bulName cterm=NONE ctermfg=darkgreen ctermbg=16
hi! bulPath cterm=NONE ctermfg=darkgrey ctermbg=16
hi! bulVersion cterm=NONE ctermfg=white ctermbg=16

syn match bulName /\v^[^ ]+/
syn match bulPath /\v[^ ]+$/
syn match bulVersion /\v \d[^ ]+/

"highlight ColorColumn ctermbg=16
  " disable > 80 column highlight

let b:current_syntax = "bundlelist"

