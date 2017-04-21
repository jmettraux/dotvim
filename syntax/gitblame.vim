
" MIT licensed

hi! gibSha cterm=NONE ctermfg=136 ctermbg=16
hi! gibAuthor cterm=NONE ctermfg=darkgrey ctermbg=16
hi! gibDate cterm=NONE ctermfg=darkgreen ctermbg=16
hi! gibHour cterm=NONE ctermfg=green ctermbg=16
hi! gibLnum cterm=NONE ctermfg=grey ctermbg=16
"
"syn match gilTree /\v^[*|\\\/ ]+/
"syn match gilTree /\v^[*| ]+/ contained
"syn match gilTags /\v\([^)]+\) /
syn match gibSha /\v^[a-fA-F0-9]+/ contained
syn match gibAuthor /\v^[a-fA-F0-9]+ .{3}/ contains=gibSha contained
syn match gibDate /\v^[a-fA-F0-9]+ .{3} \d{8}/ contains=gibAuthor contained
syn match gibHour /\v^[a-fA-F0-9]+ .{3} \d{8}\d{4}/ contains=gibDate contained
syn match gibLnum /\v^[a-fA-F0-9]+ .{3} \d{8}\d{4}\s+\d+/ contains=gibHour
syn match gibLnum /\v^\s+\d+/

highlight ColorColumn ctermbg=16
  " disable > 80 column highlight

let b:current_syntax = "gitblame"
