
"
" scripts/opennDotMd

function! s:OpenDotMd(type)

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  exe 'e .' . a:type . '.md'

  au CursorHold,InsertLeave <buffer> :w

endfunction " OpenDotMd


nnoremap <silent> <leader>n :call <SID>OpenDotMd('notes')<CR>
"nnoremap <silent> <leader>t :call <SID>OpenDotMd('todo')<CR>

