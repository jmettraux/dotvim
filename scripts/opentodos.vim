
function! s:OpenTodos()

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  exe 'e .todo.md'
  let src = search('^## src')
  if src > 0
    exe 'silent ' . src . ',$d_'
      " the _ after the d prevents the delete lines from being copied
      " in the default register
  else
    exe 'normal Go'
  endif
  exe 'normal i## src'
  let lin = line('.')
  exe 'silent r! grep -R -n -s TODO src lib spec app'
  exe 'silent ' . lin . ',$s/^\([^ ]\+\)\s\+\(.\+\)$/\1  ```\2```/e'
    " the /e makes the substitution silent
  exe 'normal o'
  exe 'normal 1G'
  write
  au CursorHold,InsertLeave <buffer> :w
endfunction " OpenTodos

nnoremap <silent> <leader>t :call <SID>OpenTodos()<CR>

