
"
" scripts/opennDotMd

function! s:OpenDotMd(type)

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  exe 'e .' . a:type . '.md'

  if line('$') == 1 && getline(1) == ''
    call append(1, [ '## .' . a:type . '.md', '', '' ])
    exe 'w'
    exe 'normal G'
  end

  au CursorHold,InsertLeave <buffer> :w

endfunction " OpenDotMd


nnoremap <silent> <leader>n :call <SID>OpenDotMd('notes')<CR>
"nnoremap <silent> <leader>t :call <SID>OpenDotMd('todo')<CR>

