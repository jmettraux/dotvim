
function! s:DiffTo(toPath)

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let a = expand('%.')
  let b = expand(a:toPath)

  exe ':%d'
  "normal G

  exe 'silent r! /usr/bin/env python ~/.vim/scripts/diff.py ' . a . ' ' . b

endfunction

command! -nargs=1 -complete=file DiffTo :call <SID>DiffTo(<f-args>)

