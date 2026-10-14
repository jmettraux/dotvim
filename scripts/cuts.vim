
"
" cuts.vim

function! s:EnterCutsFile()

  set filetype=Cuts

  let @z = system(g:_python . " ~/.vim/scripts/cuts.py", expand('%:p'))
  execute "%delete_"
  silent $put z
  execute "1delete_"
  silent update

  "if line('.') == 1 | call cursor(4, 1) | endif

  setlocal cursorline
  setlocal syntax=cuts

  "nnoremap <buffer> o :call JmOpenTreeFile()<CR>
  nnoremap <buffer> <space> :call JmOpenTreeFile()<CR>
  nnoremap <buffer> <enter> :call JmOpenTreeFile()<CR>

endfunction " EnterCutsFile

au BufRead,BufNewFile *.cuts call <SID>EnterCutsFile()


function! s:GotoCutsBuffer()

  let l:buf = bufnr('*.cuts')

  if l:buf != -1
    execute "buffer " . l:buf
  else
    echohl ErrorMsg
    echo "No buffer found with .cuts extension"
    echohl None
  endif
endfunction " GotoCutsBuffer

nnoremap <silent> <leader>z :call <SID>GotoCutsBuffer()<CR>


au BufRead .vimshorts setlocal syntax=cuts
au BufRead .vimshorts setlocal cursorline

