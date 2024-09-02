
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
      " `xclip -selection c` is equivalent to `xclip -selection clipboard`

      " Ctrl-p
      " ;v      pastes into the current buffer
      "
      " :C      copies the whole file
      " ;c      copies the current visual selection
      " :Cl     copies the current line
      " :Cr     copies the unamed register "
      " yc      copies the current line

      nnoremap <silent> <C-p> <ESC>:r ! xclip -o -selection c<CR>
      nnoremap <silent> <leader>v <ESC>:r ! xclip -o -selection c<CR>

      command! -nargs=0 C :silent w ! xclip -i -selection c
      vmap <silent> <leader>c <ESC>:'<,'>:w ! xclip -i -selection c<CR><CR>

      command! -nargs=0 Cl :silent .w ! xclip -i -selection c

      command! -nargs=0 Cr :call system('xclip -i -selection c', getreg('"'))

      nnoremap <silent> yc <ESC>yy :call system('xclip -i -selection c', getreg('"'))<CR>:echo "copied line to clipboard."<CR>
    endif
  endif
endif

"
" Remember: 1vp to copy over visually... ;-)
"

