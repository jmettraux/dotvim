
"
" scripts/jumps.vim

function! s:Jumps()

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let bn = bufnr('==Jumps')
  "let bn = JmBufferNumber('==ListFiles')

  if bn > -1 | exe '' . bn . 'bwipeout!' | endif
    " close previous ListFiles if any

  exe 'new | only'
    " | only makes it full window
  silent file ==Jumps
    " replace buffer name
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal nobuflisted
  setlocal filetype=Jumps

  setlocal noautoindent
  setlocal nocindent
  setlocal nosmartindent
  setlocal indentexpr=

  normal o== jumps
  exe 'let @z=""'
  exe 'redir @z'
  exe 'silent jumps'
  exe 'redir END'
  exe 'let @z = system("/usr/bin/env python ~/.vim/scripts/jumps.py", @z)'
  exe 'silent $put z'

  call feedkeys('1G')

"  let ln = get(a:, 1, -1)
"  if ln > 0
"    call feedkeys('' . ln . 'G')
"  else
"    call feedkeys(":call search('^[\.\/a-zA-Z0-9]', '')\r:echo\r")
"      " go to first file
"  end
"
"  exe 'silent! %s/$//'
"  exe 'silent! %s/\( [0-9]\+\)$/\1/'
"  exe 'silent! %s/\\/\//g'

  setlocal syntax=jumps
  setlocal nomodifiable
  setlocal cursorline

"  "nmap <buffer> o gF
"  "nmap <buffer> <space> gF
"  "nmap <buffer> <CR> gF
"    "
  nnoremap <buffer> o :call JmOpenTreeFile()<CR>
  nnoremap <buffer> e :call JmOpenTreeFile('edit')<CR>
  nnoremap <buffer> <space> :call JmOpenTreeFile()<CR>
  nnoremap <buffer> <CR> :call JmOpenTreeFile()<CR>

  nmap <buffer> s /
endfunction " Jumps


command! -nargs=0 JmJumps :call <SID>Jumps()
nnoremap <silent> <leader>j :call <SID>Jumps()<CR>

