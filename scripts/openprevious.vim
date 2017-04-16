
" open previous file for `vp`
"
function! s:OpenPrevious()
  exe 'new | only'
  exe 'setlocal buftype=nofile'
  exe 'setlocal bufhidden=hide'
  exe 'setlocal noswapfile'
  exe 'setlocal nobuflisted'
  "exe 'setlocal filetype=ListFiles'
  exe 'let @z=""'
  exe 'redir @z'
  exe 'silent ol'
  exe 'redir END'
  exe 'silent 0put z'
  exe 'g/COMMIT_EDITMSG/d_'
  exe 'g/NetrwTreeListing/d_'
  exe 'g/==ListFiles/d_'
  exe 'normal 2G10lgF'
  exe 'syntax sync fromstart'
endfunction " OpenPrevious

command! -nargs=0 OpenPrevious :call <SID>OpenPrevious()
"nnoremap <silent> <leader>p :call <SID>OpenPrevious()<CR>

