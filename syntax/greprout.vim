
" MIT licensed

" Quit when a (custom) syntax file was already loaded
"if exists("b:current_syntax")
"  finish
"endif

"syn case match

"syn match flBinaryFilename '^Binary file .\+ matches'
"hi def link flBinaryFilename Special
"syn match flBf '^Binary file'
"hi def link flBinaryFilename Normal

hi! groTitle cterm=NONE ctermfg=darkyellow ctermbg=16
hi! groFilename cterm=NONE ctermfg=blue ctermbg=16
hi! groLineNr cterm=NONE ctermfg=darkblue ctermbg=16
hi! groPattern cterm=NONE ctermfg=darkgreen ctermbg=16

highlight ColorColumn ctermbg=16
  " disable > 80 column highlight

syn match groTitle '^== .\+'
syn match groFilename '^[^ :]\+:'
syn match groLineNr '\d\+:'

"echo "syn match groPattern " . g:groPattern
exe "syn match groPattern " . g:groPattern

let b:current_syntax = "greprout"

