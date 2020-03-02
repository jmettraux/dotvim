
" MIT licensed

hi! jolPlain cterm=NONE ctermfg=white ctermbg=16

hi! jolSql cterm=NONE ctermfg=darkgreen ctermbg=16

hi! jolHrMethod cterm=NONE ctermfg=yellow ctermbg=16
hi! jolHrUri cterm=NONE ctermfg=yellow ctermbg=16
hi! jolHrProto cterm=NONE ctermfg=white ctermbg=16
hi! jolHrCode cterm=NONE ctermfg=green ctermbg=16
hi! jolHrNotOkCode cterm=NONE ctermfg=red ctermbg=16


highlight ColorColumn ctermbg=16
  " disable > 80 column highlight


syn match jolHrMethod '\v(GET|POST|UPDATE|DELETE|PUT|HEAD)' contained
syn match jolHrUri '\v\/[^ ]+' contained
syn match jolHrProto '\vHTTP\/[0-9.]+' contained
syn match jolHrCode '\v [23]\d\d ' contained
syn match jolHrNotOkCode '\v [01456789]\d\d ' contained
syn match jolHttpRequest '\v(GET|POST|UPDATE|DELETE|PUT|HEAD) [^ ]+ [^ ]+ \d{3}' contained contains=jolHrMethod,jolHrUri,jolHrProto,jolHrCode,jolHrNotOkCode

syn match jolSql '\v(SELECT|INSERT|UPDATE|INNER JOIN|LEFT OUTER JOIN|ORDER BY|FROM|VALUES|WHERE|ON|AND|OR|IS|AS|CAST|DESC|LIMIT \d+|BEGIN|COMMIT|GROUP BY)' contained

syn match jolPlain '\v.*' contains=jolSql,jolHttpRequest

let b:current_syntax = "jolog"

