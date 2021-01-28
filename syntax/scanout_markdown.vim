
" MIT licensed

hi! scoTitle cterm=NONE ctermfg=white ctermbg=16
hi! scoLineNumber cterm=NONE ctermfg=green ctermbg=16
hi! scoHeader cterm=NONE ctermfg=darkgray ctermbg=16
hi! scoOtherText cterm=NONE ctermfg=darkgray ctermbg=16

"
" Markdown

syn match scoLine '\v^ *[0-9]+ .*$' contains=scoLineNumber,scoHeader,scoTitle

syn match scoLineNumber '\v^ *[0-9]+' contained
syn match scoHeader '\v#+' contained
syn match scoTitle '\v [^#]+$' contained

syn match scoOtherLine '\v^ *[0-9]+ [^#].+' contains=scoLineNumber,scoOtherText
syn match scoOtherText '\v .+$' contained


let b:current_syntax = "scanout_markdown"

