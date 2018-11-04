
function! s:DeleteBuffer()

  let l = getline('.')
  let m = matchlist(l, '\v^([^ :]+)')
  if empty(m) == 1 | return | endif

  exe 'bd ' . m[1]
  call <SID>ListFiles()
endfunction " DeleteBuffer


function! s:ListFiles()

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let bn = bufnr('==ListFiles')
  if bn > -1 | exe '' . bn . 'bwipeout!' | endif
    " close previous ListFiles if any

  exe 'new | only'
    " | only makes it full window
  silent file ==ListFiles
    " replace buffer name
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal nobuflisted
  setlocal filetype=ListFiles

  setlocal noautoindent
  setlocal nocindent
  setlocal nosmartindent
  setlocal indentexpr=

  normal o== buffers
  exe 'let @z=""'
  exe 'redir @z'
  exe 'silent buffers'
  exe 'redir END'
  exe 'let @z = system("/usr/bin/env python ~/.vim/scripts/buffers.py", @z)'
  exe 'silent $put z'

  if filereadable('.errors') && getfsize('.errors') > 0
    normal o== .errors
    exe 'silent r .errors'
    normal G
  endif

  if isdirectory('.git')
    normal o== git status
    exe 'r! /usr/bin/env python ~/.vim/scripts/restatus.py'
    normal G
  endif

  if filereadable('.vimgrep') && getfsize('.vimgrep') > 0
    normal o== .vimgrep
    exe 'silent r .vimgrep'
    normal G
  endif

  if filereadable('.vimshorts') && getfsize('.vimshorts') > 0
    normal o== .vimshorts
    exe 'silent r! /usr/bin/env python ~/.vim/scripts/cat.py .vimshorts'
    normal G
  end

  "let l = line('.') + 1
  exe 'let @z=""'
  exe 'redir @z'
  exe 'silent oldfiles'
  exe 'redir END'
  exe 'let @z = system("/usr/bin/env python ~/.vim/scripts/recentfiles.py", @z)'
  exe 'silent $put z'

  "exe '%sno#^' . fnamemodify(expand("."), ":~:.") . '/##'
    " shorten paths if in a current dir subdir

  exe 'silent g/^$/d_'
  exe 'silent %s/^==/==/'
    " respace sections
  call append(line('$'), '')
    " append final, blank, line

  "call search('== recent')
  "let l = line('.') + 1
  "exe '' . l . ',$sort u'
    " sort recent files

  call feedkeys('1G')
  call feedkeys(":call search('^[\.\/a-zA-Z0-9]', '')\r:echo\r")
    " go to first file

  setlocal syntax=buffers
  setlocal nomodifiable

  "nmap <buffer> o gF
  "nmap <buffer> <space> gF
  "nmap <buffer> <CR> gF
    "
  nnoremap <buffer> o :call JmOpenTreeFile()<CR>
  nnoremap <buffer> <space> :call JmOpenTreeFile()<CR>
  nnoremap <buffer> <CR> :call JmOpenTreeFile()<CR>

  nnoremap <buffer> d :call <SID>DeleteBuffer()<CR>

  nmap <buffer> s /

  nmap <buffer> bb :call search('^== buffers', '')<CR>:echo<CR>j
  nmap <buffer> rr :call search('^== \.errors', '')<CR>:echo<CR>jll
  nmap <buffer> tt :call search('^== git status', '')<CR>:echo<CR>j
  nmap <buffer> vv :call search('^== \.vimgrep', '')<CR>:echo<CR>j
  nmap <buffer> ss :call search('^== \.vimshorts', '')<CR>:echo<CR>j
  nmap <buffer> cc :call search('^== recent', '')<CR>:echo<CR>j
    " silently go to "^== xxx"

  nmap <buffer> a :call search('^== ', '')<CR>:echo<CR>0j
  nmap <buffer> A :call search('^== ', 'b')<CR>:call search('^== ', 'b')<CR>:echo<CR>j
    " silently go to next/previous "== "

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

