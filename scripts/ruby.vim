
function! s:BxsFnameAndLnumber()
  let @z = 'bxs ' . fnamemodify(expand("%"), ":~:.") . ':' . line('.')
  exe 'silent ! echo "' . @z . '" | pbcopy'
  exe 'redraw!'
  echo "\"" . getreg("z") . "\" copied"
endfunction " BxsFnameAndLnumber

nnoremap <silent> <leader>@ :call <SID>BxsFnameAndLnumber()<CR>

