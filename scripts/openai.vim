
" scripts/openai.vim

" with inspiration from https://github.com/CoderCookE/vim-chatgpt


function! s:OpenAiChatComplete(prompt)

  let @z = system(g:_python . " ~/.vim/scripts/openai_complete.py", a:prompt)
  silent $put z
  normal <c-g>
endfunction " OpenAiChatComplete


function! s:OpenAiChatPushLine()

  if getline('.') !~ '\v^#+\s+'
    exe 'normal I### 0'
  endif
  let l = getline('.')
  exe 'normal o'

  redraw
  write

  call <SID>OpenAiChatComplete(l)
  write
endfunction " OpenAiChatPushLine

"command! -nargs=0 Prompt :call <SID>OpenAiChatPushLine()
nmap <buffer> ?? :call <SID>OpenAiChatPushLine()


function! s:OpenAiChatPushBlock() range

  let ls = getline(a:firstline, a:lastline)

  exe '' . a:firstline . ',' . a:lastline . 'delete'
    "
  let ln = a:firstline - 1
  for l in ls
    if trim(l) == ''
      call append(ln, '>')
    else
      call append(ln, '> ' . l)
    endif
    let ln = ln + 1
  endfor
  call append(ln, '')

  redraw
  write

  call <SID>OpenAiChatComplete(ls)
  write
endfunction " OpenAiChatPushBlock

"vnoremap ?? :call <SID>OpenAiChatPushBlock()
vmap <buffer> ?? :call <SID>OpenAiChatPushBlock()
vmap <buffer> >> :call <SID>OpenAiChatPushBlock()


function! s:OpenAiList()

  let @z = system(g:_python . ' ~/.vim/scripts/openai_list.py')
  silent $put z
  normal <c-g>
endfunction " OpenAiList

command! -nargs=0 OpenAiList :call <SID>OpenAiList()

