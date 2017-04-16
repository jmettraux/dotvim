
function! s:OpenScratch(type)

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  exe 'e .' . a:type . '.md'
  au CursorHold,InsertLeave <buffer> :w
endfunction " OpenScratch

nnoremap <silent> <leader>n :call <SID>OpenScratch('notes')<CR>
"nnoremap <silent> <leader>t :call <SID>OpenScratch('todo')<CR>

