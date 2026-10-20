
"
" syntax/cuts.vim

" (<pat>)@<=<match>               ~~~ positive lookbehind
"           <match>(<pattern>)@=  ~~~ positive lookahead
"   (<pat)@!<match>               ~~~ negative lookbehind
"           <match>(<pat>)@!      ~~~ negative lookahead

"hi def link ctsComment Comment
hi! ctsTitle cterm=NONE ctermfg=green ctermbg=16
hi! ctsHash cterm=NONE ctermfg=238 ctermbg=16
hi! ctsFileName cterm=NONE ctermfg=darkyellow ctermbg=16
hi! ctsSlash cterm=NONE ctermfg=darkgrey ctermbg=16
hi! ctsDot cterm=NONE ctermfg=darkgrey ctermbg=16
hi! ctsExt cterm=NONE ctermfg=green ctermbg=16
hi! ctsSize cterm=bold ctermfg=238 ctermbg=16
hi! ctsLines cterm=NONE ctermfg=darkgrey ctermbg=16
hi! ctsDir cterm=NONE ctermfg=darkgreen ctermbg=16
hi! ctsExt cterm=NONE ctermfg=grey ctermbg=16
hi! ctsAge cterm=NONE ctermfg=238 ctermbg=16
"hi! ctsGit cterm=NONE ctermfg=white ctermbg=16
hi! ctsGitAdd cterm=NONE ctermfg=white ctermbg=16
hi! ctsGitRem cterm=NONE ctermfg=white ctermbg=16
hi! ctsOther cterm=NONE ctermfg=darkgrey ctermbg=16

syn match ctsOther /./

syn match ctsFileName '\v *.+\/.+$' contains=ctsDir,ctsSlash,ctsDot,ctsExt,ctsSize,ctsLines,ctsAge,ctsGit
  " at least a slash...

syn match ctsGitAdd '\v\+[0-9]+' contained
syn match ctsGitRem '\v-[0-9]+' contained

syn match ctsSize '\v [0-9]+[PTMKB]' contained
syn match ctsLines '\v [0-9]+L' contained
syn match ctsGit '\v \+[0-9]+\-[0-9]+' contained contains=ctsGitAdd,ctsGitRem
syn match ctsAge '\v ([0-9]+[dhms])+' contained

syn match ctsDir '\v[^\/]+(\/)@=' contained
syn match ctsExt '\v([a-zA-Z0-9_]\.)@<=[a-zA-Z]+( [0-9])@=' contained
syn match ctsSlash '/' contained
syn match ctsDot '\v\.' contained

syn match ctsTitle '\v^#.+$' contains=ctsHash
syn match ctsHash '\v#+' contained

let b:current_syntax = "cuts"

