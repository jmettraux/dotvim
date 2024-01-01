
"
" scripts/quoteword.vim


"" from http://vim.wikia.com/wiki/Simple_Macros_to_quote_and_unquote_a_word
""
"" 'quote' a word
"nnoremap qw :silent! normal mpea'<Esc>bi'<Esc>`pl
"" double "quote" a word
"nnoremap qd :silent! normal mpea"<Esc>bi"<Esc>`pl

" 'quote' a word
nnoremap qw :silent! normal yiwi'<ESC>ea'<ESC>
xnoremap qw c''<ESC>hp
  "
" double "quote" a word
nnoremap qd :silent! normal yiwi"<ESC>ea"<ESC>
xnoremap qd c""<ESC>hp
  "
" `backquote` a word
nnoremap qb :silent! normal yiwi`<ESC>ea`<ESC>
xnoremap qb c``<ESC>hp

" surround by _
nnoremap q_ :silent! normal yiwi_<ESC>ea_<ESC>
xnoremap q_ c__<ESC>hp

" surround by *
nnoremap q* :silent! normal yiwi**<ESC>ea**<ESC>
xnoremap q* c****<ESC>hhp

" remove quotes from a word
nnoremap wq :silent! normal mpeld bhd `ph<CR>

