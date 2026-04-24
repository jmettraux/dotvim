
" scripts/claude.vim


function! s:ClaudeChatComplete(prompt)

  "let @z = system(g:_python . " ~/.vim/scripts/claude_complete.py 2>/dev/null", a:prompt)
  let @z = system(g:_python . " ~/.vim/scripts/claude_complete.py 2>.deepseek.stderr.txt", a:prompt)
  silent $put z
  normal <c-g>
endfunction " ClaudeChatComplete


function! s:ClaudeChatPushLine()

  if getline('.') !~ '\v^#+\s+'
    exe 'normal I### 0'
  endif
  let l = getline('.')
  exe 'normal o'

  redraw
  write

  call <SID>ClaudeChatComplete(l)
  write
endfunction " ClaudeChatPushLine

"command! -nargs=0 Prompt :call <SID>ClaudeChatPushLine()


function! s:ClaudeChatPushBlock() range

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

  call <SID>ClaudeChatComplete(ls)
  write
endfunction " ClaudeChatPushBlock


"function! s:OpenAiList()
"
"  let @z = system(g:_python . ' ~/.vim/scripts/openai_list.py')
"  silent $put z
"  normal <c-g>
"endfunction " OpenAiList
"
"command! -nargs=0 OpenAiList :call <SID>OpenAiList()


au BufReadPost,BufNewFile .claude.md
  \ nnoremap <buffer> ?? :call <SID>ClaudeChatPushLine()
au BufReadPost,BufNewFile .claude.md
  \ vnoremap <buffer> ?? :call <SID>ClaudeChatPushBlock()
au BufReadPost,BufNewFile .claude.md
  \ vnoremap <buffer> >> :call <SID>ClaudeChatPushBlock()

