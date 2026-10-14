
"
" cuts.vim

function! s:EnterCutsFile()

  set filetype=Cuts

  let @z = system(g:_python . " ~/.vim/scripts/cuts.py", expand('%:p'))
  execute "%delete_"
  silent $put z
  execute "1delete_"
  silent update

  setlocal syntax=cuts

  nnoremap <buffer> o :call JmOpenTreeFile()<CR>
  nnoremap <buffer> <space> :call JmOpenTreeFile()<CR>
  nnoremap <buffer> <enter> :call JmOpenTreeFile()<CR>

endfunction " EnterCutsFile

au BufRead,BufNewFile *.cuts call <SID>EnterCutsFile()

