
" copy.vim


" copying and pasting
"
if g:isWindows

  " TODO bring back

  " cygwin
  nnoremap <silent> <C-p> <ESC>:r ! getclip<CR>
  nnoremap <silent> <leader>v <ESC>:r ! getclip<CR>
  command! -nargs=0 C :silent w ! putclip
  vmap <silent> <leader>c <ESC>:'<,'>:w ! putclip<CR><CR>

else

  if g:isUnix

    if g:isDarwin

      " TODO bring back

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
      " :CopyFile      copies the whole file
      " ;c             copies the current visual selection
      " :CopyLine      copies the current line
      " :CopyRegister  copies the unamed register "
      " yc             copies the current line

      nnoremap <silent> <C-p> <ESC>:r ! xclip -o -selection c<CR>
      nnoremap <silent> <leader>v <ESC>:r ! xclip -o -selection c<CR>

      command! -nargs=0 CopyFile :silent w ! xclip -i -selection c
      command! -nargs=0 CopyLine :silent .w ! xclip -i -selection c
      command! -nargs=0 CopyRegister :call system('xclip -i -selection c', getreg('"'))

      nnoremap <silent> <leader>c <ESC>:w ! xclip -i -selection c<CR><CR>
      vmap <silent> <leader>c <ESC>:'<,'>:w ! xclip -i -selection c<CR><CR>

      nnoremap <silent> yc <ESC>yy :call system('xclip -i -selection c', getreg('"'))<CR>:echo "copied line to clipboard."<CR>
    endif
  endif
endif

"
" Remember: 1vp to copy over visually... ;-)
"

