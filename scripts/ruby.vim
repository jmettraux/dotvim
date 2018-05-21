
function! s:BxsFnameAndLnumber()

  "exe '! echo "bxs ' . @% . ':' . line('.') . '" | pbcopy'
    " expensive, creates a subprocess, the below kp is cleaner

  let @x = 'bxs ' . @% . ':' . line('.')
  exe '"xkp'
  exe 'echo "\"" . getreg("x") . "\" copied"'
endfunction " BxsFnameAndLnumber

nnoremap <silent> <leader>@ :call <SID>BxsFnameAndLnumber()<CR>

