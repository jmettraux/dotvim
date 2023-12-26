
" copy.vim


" copying and pasting
"
if g:isWindows
  " cygwin
  nnoremap <silent> <C-p> <ESC>:r ! getclip<CR>
  nnoremap <silent> <leader>v <ESC>:r ! getclip<CR>
  command! -nargs=0 C :silent w ! putclip
  vmap <silent> <leader>c <ESC>:'<,'>:w ! putclip<CR><CR>
else
  if g:isUnix
    if g:isDarwin
      nnoremap <silent> <C-p> <ESC>:r ! pbpaste<CR>
      nnoremap <silent> <leader>v <ESC>:r ! pbpaste<CR>
      command! -nargs=0 C :silent w ! pbcopy
      vmap <silent> <leader>c <ESC>:'<,'>:w ! pbcopy<CR><CR>
    else
      " 2023-12-26 changing from `xclip -selection c` to `xclip`
      nnoremap <silent> <C-p> <ESC>:r ! xclip -o<CR>
      nnoremap <silent> <leader>v <ESC>:r ! xclip -o<CR>
      command! -nargs=0 C :silent w ! xclip -i
      vmap <silent> <leader>c <ESC>:'<,'>:w ! xclip -i<CR><CR>
      command! -nargs=0 Cl :silent .w ! xclip -i
        " :Cl<CR> to copy current line to the clipboard
      command! -nargs=0 Cr :call system('xclip -i', getreg('"'))
        " https://stackoverflow.com/questions/10780469/vim-pipe-register-to-external-command
      nnoremap <silent> yc <ESC>yy :call system('xclip -i', getreg('"'))<CR>:echo "copied line to clipboard."<CR>
    endif
  endif
endif

"
" 1vp to copy over visually... ;-)
"

