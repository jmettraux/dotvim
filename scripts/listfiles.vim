
function! s:DeleteBuffer()

  let l = getline('.')
  let m = matchlist(l, '\v^([^ :]+)')
  if empty(m) == 1 | return | endif

  exe 'bd ' . m[1]
  call <SID>ListFiles()
endfunction " DeleteBuffer


function! s:ListFiles()

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  if bufnr('==ListFiles') > 0 | exe 'bwipeout! ==ListFiles' | endif
    " close previous ListFiles if any

  exe 'new | only'
    " | only makes it full window
  exe 'silent file ==ListFiles'
    " replace buffer name
  exe 'setlocal buftype=nofile'
  exe 'setlocal bufhidden=hide'
  exe 'setlocal noswapfile'
  exe 'setlocal nobuflisted'
  exe 'setlocal filetype=ListFiles'

  let l = line('.') + 1
  exe 'let @z=""'
  exe 'redir @z'
  exe 'silent echo "== buffers"'
  exe 'silent buffers'
  exe 'redir END'
  exe 'silent $put z'
    "
  exe '%s/^[0-9]\+: //e'
  exe '%s/^\s\+\d\+[^\"]\+"//e'
  exe '%s/"\s\+line /:/e'
    "
  exe 'silent! ' . l . ',g/greprout/d_'
  exe 'silent! ' . l . ',g/showtreeout/d_'
    " don't show recent .greprout or .showtreeout files (they're gone)
  "exe '' . l . ',g/^== git (diff|show)/d_'

  if filereadable('.errors') && getfsize('.errors') > 0
    exe 'let @z=""'
    exe 'redir @z'
    exe 'silent echo "== .errors"'
    exe 'redir END'
    exe 'silent $put z'
    exe 'silent r .errors'
  endif

  if isdirectory('.git')
    exe 'let @z=""'
    exe 'redir @z'
    exe 'silent echo "== git status"'
    exe 'redir END'
    exe 'silent $put z'
    "exe 'silent r! (echo "`git status`"; echo "`git diff --stat`") | perl ~/.vim/scripts/restatus.pl'
    exe 'r! /usr/bin/env python ~/.vim/scripts/restatus.py'
  endif

  "let l = line('.') + 1
  exe 'let @z=""'
  exe 'redir @z'
  exe 'silent oldfiles'
  exe 'redir END'
  exe 'let @z = system("/usr/bin/env python ~/.vim/scripts/recentfiles.py", @z)'
  exe 'silent $put z'

  "exe '%sno#^' . fnamemodify(expand("."), ":~:.") . '/##'
    " shorten paths if in a current dir subdir

  exe 'g/^$/d_'
  exe '%s/^==/==/'
    " respace sections

  "call search('== recent')
  "let l = line('.') + 1
  "exe '' . l . ',$sort u'
    " sort recent files

  call feedkeys('1G')
  call feedkeys(":call search('^[\.\/a-zA-Z0-9]', '')\r:echo\r")
    " go to first file

  setlocal syntax=buffers

  "nmap <buffer> o gF
  "nmap <buffer> <space> gF
  "nmap <buffer> <CR> gF
    "
  nnoremap <buffer> o :call JmOpenTreeFile()<CR>
  nnoremap <buffer> <space> :call JmOpenTreeFile()<CR>
  nnoremap <buffer> <CR> :call JmOpenTreeFile()<CR>

  nnoremap <buffer> d :call <SID>DeleteBuffer()<CR>

  nmap <buffer> v /

  nmap <buffer> rr :call search('^== \.errors', '')<CR>:echo<CR>jll
    " silently go to "== .errors" well... the commands appear downstairs...

  nmap <buffer> a :call search('^== ', '')<CR>:echo<CR>0
  nmap <buffer> A :call search('^== ', 'b')<CR>:echo<CR>0
    " silently go to next "== "

  nmap <buffer> gl :call search('^== buffers', '')<CR>}k
    " silently go to last file in buffer
    " reminder type "}" to go to next blank line... See also "{", ")" and "("
endfunction " ListFiles


command! -nargs=0 ListFiles :call <SID>ListFiles()
nnoremap <silent> <leader>b :call <SID>ListFiles()<CR>

nnoremap <silent> <leader>B :exe 'bdelete ' . join(range(1, bufnr('$')), ' ')<CR>:call <SID>ListFiles()<CR>


function! s:GitAdd()

  let path = JmDetermineTreePathAndLine()[0]
  let s = system('git add ' . path)
  call <SID>ListFiles()
  echo s
endfunction " GitAdd

command! -nargs=0 GitAdd :call <SID>GitAdd()
command! -nargs=0 Gadd :call <SID>GitAdd()

