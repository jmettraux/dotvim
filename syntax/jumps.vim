
"
" syntax/jumps.vim

  " (<pattern>)@<=<match>  ~~~ positive lookbehind
  " <match>(<pattern>)@=   ~~~ positive lookahead
  " (<pattern>)@!<match>   ~~~ negative lookbehind
  " <match>(<pattern>)@!   ~~~ negative lookahead

"highlight ColorColumn ctermbg=16
  " disable > 80 column highlight

hi! jmpTitle cterm=NONE ctermfg=lightgrey ctermbg=16
hi! jmpFileName cterm=NONE ctermfg=darkyellow ctermbg=16
hi! jmpSlash cterm=NONE ctermfg=darkgrey ctermbg=16
hi! jmpExt cterm=NONE ctermfg=green ctermbg=16
hi! jmpDot cterm=NONE ctermfg=darkgrey ctermbg=16
hi! jmpColon cterm=NONE ctermfg=darkgrey ctermbg=16
hi! jmpDir cterm=NONE ctermfg=darkgreen ctermbg=16
hi! jmpTail cterm=NONE ctermfg=grey ctermbg=16
hi! jmpCol cterm=NONE ctermfg=238 ctermbg=16
hi! jmpLine cterm=NONE ctermfg=darkgrey ctermbg=16

syn match jmpTitle '\v^\=\= jumps'
syn match jmpFileName '\v^ *[^:]+:[0-9]+ +[0-9]+.*$' contains=jmpSlash,jmpDot,jmpExt,jmpColon,jmpDir,jmpLine,jmpCol,jmpTail
syn match jmpExt '\v(\.)@<=.+(:[0-9]+ +[0-9]+)@=' contained
syn match jmpSlash '/' contained
syn match jmpDot '\v\.' contained
syn match jmpColon ':' contained
syn match jmpDir '\v^ [^\/:]+(\/)@=' contained
syn match jmpLine '\v(:)@<=[0-9]+ +' contained
syn match jmpCol '\v(:[0-9]+ +)@<=[0-9]+' contained
syn match jmpTail '\v(:[0-9]+ +[0-9]+)@<=(.+)$' contained

let b:current_syntax = "jumps"

