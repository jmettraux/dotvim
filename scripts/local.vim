
" scripts/local.vim


function! s:LocalChatComplete(prompt)

  "let @z = system(g:_python . " ~/.vim/scripts/local_complete.py 2>/dev/null", a:prompt)
  let @z = system(g:_python . " ~/.vim/scripts/local_complete.py 2>.local.stderr.txt", a:prompt)
  silent $put z
  normal <c-g>
endfunction " LocalChatComplete


function! s:LocalChatPushLine()

  if getline('.') !~ '\v^#+\s+'
    exe 'normal I### 0'
  endif
  let l = getline('.')
  exe 'normal o'

  redraw
  write

  call <SID>LocalChatComplete(l)
  write
endfunction " LocalChatPushLine

"command! -nargs=0 Prompt :call <SID>LocalChatPushLine()


function! s:LocalChatPushBlock() range

  let ls = getline(a:firstline, a:lastline)

  exe '' . a:firstline . ',' . a:lastline . 'delete'
  call append(a:firstline - 1 , '### >')
  call append(a:firstline + 0, '')
    "
  let ln = a:firstline + 1
  for l in ls
    if trim(l) == ''
      call append(ln, '>')
    else
      call append(ln, '> ' . l)
    endif
    let ln = ln + 1
  endfor
  "call append(ln, '')

  redraw
  write

  call <SID>LocalChatComplete(ls)
  write
endfunction " LocalChatPushBlock


"function! s:OpenAiList()
"
"  let @z = system(g:_python . ' ~/.vim/scripts/openai_list.py')
"  silent $put z
"  normal <c-g>
"endfunction " OpenAiList
"
"command! -nargs=0 OpenAiList :call <SID>OpenAiList()


au BufReadPost,BufNewFile .local.md
  \ nnoremap <buffer> ?? :call <SID>LocalChatPushLine()
au BufReadPost,BufNewFile .local.md
  \ vnoremap <buffer> ?? :call <SID>LocalChatPushBlock()
au BufReadPost,BufNewFile .local.md
  \ vnoremap <buffer> >> :call <SID>LocalChatPushBlock()

