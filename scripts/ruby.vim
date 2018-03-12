
function! s:BxsFnameAndLnumber()
  exe '! echo "bxs ' . @% . ':' . line('.') . '" | pbcopy'
endfunction " BxsFnameAndLnumber

nnoremap <silent> <leader>@ :call <SID>BxsFnameAndLnumber()<CR>

