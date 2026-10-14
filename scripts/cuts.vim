
"
" cuts.vim

function! s:EnterCutsFile()

  let @z = system(g:_python . " ~/.vim/scripts/cuts.py", expand('%:p'))
  silent $put z

  setlocal syntax=cuts

  nnoremap <buffer> o :call JmOpenTreeFile()<CR>
  nnoremap <buffer> <space> :call JmOpenTreeFile()<CR>
  nnoremap <buffer> <enter> :call JmOpenTreeFile()<CR>
endfunction " EnterCutsFile

au BufReadPost,BufNewFile *.cuts call <SID>EnterCutsFile()

