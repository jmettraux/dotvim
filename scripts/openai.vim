
" scripts/openai.vim

" with inspiration from https://github.com/CoderCookE/vim-chatgpt


function! s:OpenAiChatComplete(prompt)

  let @z = system("/usr/bin/env python ~/.vim/scripts/openai_complete.py", a:prompt)
  silent $put z
  normal <c-g>
endfunction " OpenAiChatComplete

function! s:OpenAiChatPushLine()

  if getline('.') !~ '\v^#+\s+'
    exe 'normal I### 0'
    exe 'w'
  endif
  let l = getline('.')
  exe 'normal o'

  redraw

  call <SID>OpenAiChatComplete(l)
  exe 'w'
endfunction " OpenAiChatPushLine

"command! -nargs=0 Prompt :call <SID>OpenAiChatPushLine()
nnoremap ?? :call <SID>OpenAiChatPushLine()

