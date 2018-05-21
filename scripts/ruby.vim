
function! s:BxsFnameAndLnumber()

  let @z = 'bxs ' . fnamemodify(expand("%"), ":~:.") . ':' . line('.')

  if has("win32")
    " cygwin
    exe 'silent ! echo "' . @z . '" | putclip'
  else
    if has("unix")
      let s:uname = system("uname")
      if s:uname == "Darwin\n"
        exe 'silent ! echo "' . @z . '" | pbcopy'
      else
        exe 'silent ! echo "' . @z . '" | xclip -i'
      endif
    endif
  endif

  exe 'redraw!'
  echo "\"" . getreg("z") . "\" copied"
endfunction " BxsFnameAndLnumber

nnoremap <silent> <leader>@ :call <SID>BxsFnameAndLnumber()<CR>

