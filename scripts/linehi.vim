
"
" linehi.vim
"
" https://vimtricks.com/p/highlight-specific-lines/

" define line highlight color
highlight JmLineHighlight ctermfg=white ctermbg=darkgray guibg=darkgray

" highlight the current line
nnoremap <silent> { :call matchadd('JmLineHighlight', '\%'.line('.').'l')<CR>

" clear all the highlighted lines
nnoremap <silent> } :call clearmatches()<CR>

