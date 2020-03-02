
" MIT licensed

hi! jolPlain cterm=NONE ctermfg=white ctermbg=16
hi! jolSql cterm=NONE ctermfg=darkgreen ctermbg=16
hi! jolHttpRequest cterm=NONE ctermfg=yellow ctermbg=16

highlight ColorColumn ctermbg=16
  " disable > 80 column highlight

syn match jolHttpRequest '\v(GET|POST|UPDATE|DELETE|PUT) [^ ]+' contained
syn match jolSql '\v(SELECT|INSERT|UPDATE|INNER JOIN|LEFT OUTER JOIN|ORDER BY|FROM|VALUES|WHERE|ON|AND|OR|IS|AS|CAST|DESC|LIMIT \d+|BEGIN|COMMIT|GROUP BY)' contained
syn match jolPlain '\v.*' contains=jolSql,jolHttpRequest

let b:current_syntax = "jolog"

