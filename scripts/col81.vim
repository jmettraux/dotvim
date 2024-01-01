
"
" script/col81.vim


"let &colorcolumn = join(range(81, 999), ',')
let &colorcolumn = '81'
highlight ColorColumn ctermbg=235 guibg=#2c2d27
  "
"nnoremap <leader>] :hi ColorColumn ctermbg=16<CR>:echo<CR>
"nnoremap <leader>[ :hi ColorColumn ctermbg=235 guibg=#2c2d27<CR>:echo<CR>
command! Col81 :highlight ColorColumn ctermbg=235 guibg=#2c2d27
command! NoCol81 :hi clear ColorColumn

"command! Col81 :let &colorcolumn= '81'
"command! NoCol81 :let &colorcolumn= '999'

  " for now show col81 all the time...



au BufNewFile,BufRead .chat.md  hi ColorColumn ctermbg=16
  " don't highlight col > 80 for .chat.md

