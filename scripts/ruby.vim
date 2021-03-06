
function! s:BxsFnameAndLnumber()

  let @z = 'bxs ' . fnamemodify(expand("%"), ":~:.") . ':' . line('.')

  if has("win32")
    " cygwin
    exe 'silent ! echo "' . @z . '" | putclip'
    exe 'redraw!'
    echo "\"" . getreg("z") . "\" copied"
  else
    if has("unix")
      if g:uname == "Darwin"
        "exe 'silent ! echo "' . @z . '" | bcopy'
        exe 'silent ! osascript ~/.vim/scripts/bxs.applescript "' . @z . '"'
        exe 'redraw!'
      else
        exe 'silent ! echo "' . @z . '" | xclip -i'
        exe 'redraw!'
        echo "\"" . getreg("z") . "\" copied"
      endif
    endif
  endif

endfunction " BxsFnameAndLnumber

nnoremap <silent> <leader>@ :call <SID>BxsFnameAndLnumber()<CR>


function! s:Bxs()

  if ! has("unix") | return | endif
  if g:uname != "Darwin" | return | endif

  let @z = "bxs <cWORD>"

  exe 'silent ! osascript ~/.vim/scripts/bxs.applescript "' . @z . '"'
  exe 'redraw!'
endfunction " Bxs

command! -nargs=0 Bxs :call <SID>Bxs()

