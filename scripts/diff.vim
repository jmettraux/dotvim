
function! s:DiffFrom(toPath)

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let a = expand(a:toPath)
  let b = expand('%.')

  exe ':%d'
  exe 'silent r! /usr/bin/env python ~/.vim/scripts/diff.py ' . a . ' ' . b
endfunction

function! s:DiffTo(toPath)

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let a = expand('%.')
  let b = expand(a:toPath)

  exe ':%d'
  exe 'silent r! /usr/bin/env python ~/.vim/scripts/diff.py ' . a . ' ' . b
endfunction

command! -nargs=1 -complete=file DiffFrom :call <SID>DiffFrom(<f-args>)
command! -nargs=1 -complete=file DiffTo :call <SID>DiffTo(<f-args>)

