
" MIT licensed

hi! gilSha cterm=NONE ctermfg=136 ctermbg=16
hi! gilTags cterm=NONE ctermfg=darkgreen ctermbg=16
hi! gilDate cterm=NONE ctermfg=darkgrey ctermbg=16
hi! gilNav cterm=NONE ctermfg=darkgrey ctermbg=16
hi! gilLine cterm=NONE ctermfg=grey ctermbg=16

syn match gilNav /\v^[*|\\/ ]+/ contained
syn match gilSha /\v^[*|\\/ ]+[a-fA-F0-9]+/ contains=gilNav
syn match gilAuthor /\v^[*|\\/ ]+[a-fA-F0-9]+ [^ ]+/ contains=gilSha
syn match gilDate /\v^[*|\\/ ]+[a-fA-F0-9]+ [^ ]+ [0-9]{8} [0-9]{4}/ contains=gilAuthor
syn match gilTags /\v^[*|\\/ ]+[a-fA-F0-9]+ [^ ]+ [0-9]{8} [0-9]{4} (\([^)]+\) )?/ contains=gilDate
syn match gilLine /\v^[*|\\/ ]+[a-fA-F0-9]+ [^ ]+ [0-9]{8} [0-9]{4} (\([^)]+\) )? .+/ contains=gilTags

highlight ColorColumn ctermbg=16
  " disable > 80 column highlight

let b:current_syntax = "gitlog"

