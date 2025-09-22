
" (<pat>)@<=<match>               ~~~ positive lookbehind
"           <match>(<pattern>)@=  ~~~ positive lookahead
"   (<pat)@!<match>               ~~~ negative lookbehind
"           <match>(<pat>)@!      ~~~ negative lookahead

hi! gilSha cterm=NONE ctermfg=136 ctermbg=16
hi! gilTags cterm=NONE ctermfg=green ctermbg=16
hi! gilDate cterm=NONE ctermfg=grey ctermbg=16
hi! gilHour cterm=NONE ctermfg=238 ctermbg=16
hi! gilMonth cterm=NONE ctermfg=darkgrey ctermbg=16
hi! gilYear cterm=NONE ctermfg=238 ctermbg=16
hi! gilNav cterm=NONE ctermfg=238 ctermbg=16
hi! gilLine cterm=NONE ctermfg=grey ctermbg=16
hi! gilAuthor cterm=NONE ctermfg=darkgreen ctermbg=16

hi! gilPath cterm=NONE ctermfg=darkgreen ctermbg=16
hi! gilTitleLine cterm=NONE ctermfg=lightgrey ctermbg=16

syn match gilNav /\v^[*|\\/ ]+/

syn match gilNav /\v^[*|\\/ ]+/ contained
syn match gilSha /\v^[*|\\/ ]+[a-fA-F0-9]+/ contains=gilNav
syn match gilAuthor /\v^[*|\\/ ]+[a-fA-F0-9]+ [^ ]+/ contains=gilSha
syn match gilDate /\v^[*|\\/ ]+[a-fA-F0-9]+ [^ ]+ [0-9]{8} [0-9]{4}/ contains=gilAuthor,gilYear,gilMonth,gilHour contained
syn match gilTags /\v^[*|\\/ ]+[a-fA-F0-9]+ [^ ]+ [0-9]{8} [0-9]{4} (\([^)]+\))?/ contains=gilDate
syn match gilLine /\v^[*|\\/ ]+[a-fA-F0-9]+ [^ ]+ [0-9]{8} [0-9]{4} (\([^)]+\))? .+/ contains=gilTags
syn match gilHour /\v [0-9]{4}( )@=/ contained
syn match gilMonth /\v( [0-9]{4})@<=[0-9]{2}([0-9]{2} )@=/ contained
syn match gilYear /\v 20[0-9]{2}([0-9]{4} )@=/ contained

syn match gilPath /\v [^ ]+$/ contained
syn match gilTitleLine /\v^\=\= .+$/ contains=gilPath


let b:current_syntax = "gitlog"

