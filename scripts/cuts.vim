
" cuts.vim

function! s:EnterCutsFile()

  setlocal syntax=cuts

  nnoremap <buffer> o :call JmOpenTreeFile()<CR>
  nnoremap <buffer> <space> :call JmOpenTreeFile()<CR>
endfunction " EnterCutsFile

au BufReadPost,BufNewFile *.cuts call <SID>EnterCutsFile()

