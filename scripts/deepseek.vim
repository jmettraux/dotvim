
" scripts/deepseek.vim


function! s:DeepseekChatComplete(prompt)

  let @z = system(g:_python . " ~/.vim/scripts/deepseek_complete.py 2>/dev/null", a:prompt)
  silent $put z
  normal <c-g>
endfunction " DeepseekChatComplete


function! s:DeepseekChatPushLine()

  if getline('.') !~ '\v^#+\s+'
    exe 'normal I### 0'
  endif
  let l = getline('.')
  exe 'normal o'

  redraw
  write

  call <SID>DeepseekChatComplete(l)
  write
endfunction " DeepseekChatPushLine

"command! -nargs=0 Prompt :call <SID>DeepseekChatPushLine()


function! s:DeepseekChatPushBlock() range

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

  call <SID>DeepseekChatComplete(ls)
  write
endfunction " DeepseekChatPushBlock


"function! s:OpenAiList()
"
"  let @z = system(g:_python . ' ~/.vim/scripts/openai_list.py')
"  silent $put z
"  normal <c-g>
"endfunction " OpenAiList
"
"command! -nargs=0 OpenAiList :call <SID>OpenAiList()


au BufReadPost,BufNewFile .deep.md
  \ nnoremap <buffer> ?? :call <SID>DeepseekChatPushLine()
au BufReadPost,BufNewFile .deep.md
  \ vnoremap <buffer> ?? :call <SID>DeepseekChatPushBlock()
au BufReadPost,BufNewFile .deep.md
  \ vnoremap <buffer> >> :call <SID>DeepseekChatPushBlock()

