
" scripts/openai.vim

" with inspiration from https://github.com/CoderCookE/vim-chatgpt


function! s:OpenAiChatComplete(prompt)

  put =''
  let @z = system("/usr/bin/env python ~/.vim/scripts/openai_complete.py", a:prompt)
  silent $put z
  normal <c-g>
endfunction " OpenAiChatComplete

function! s:OpenAiChatPushLine()

  exe 'normal "kyy'
  call <SID>OpenAiChatComplete(getreg('k'))
endfunction " OpenAiChatPushLine

"command! -nargs=0 Prompt :call <SID>OpenAiChatPushLine()
nnoremap ?? :call <SID>OpenAiChatPushLine()

