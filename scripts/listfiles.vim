
"
" scripts/listfiles.vim


function! s:DeleteBuffer()

  let l = getline('.')
  let m = matchlist(l, '\v^([^ :]+)')
  if empty(m) == 1 | return | endif

  exe 'bd ' . m[1]
  call <SID>ListFiles(line('.'))
endfunction " DeleteBuffer

function! s:GitAddFile()

  let path = JmDetermineTreePath()
  if empty(path) | return 0 | endif

  call system('git add ' . path)

  call <SID>ListFiles(line('.'))

  echo 'Added ' . path . ' to Git'
endfunction " GitAddFile

function! s:GitUnstageFile()

  let path = JmDetermineTreePath()
  if empty(path) | return 0 | endif

  call system('git restore --staged ' . path)

  call <SID>ListFiles(line('.'))

  echo 'Unstaged ' . path
endfunction " GitAddFile


function! s:ListFiles(...)

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let bn = bufnr('==ListFiles')
  "let bn = JmBufferNumber('==ListFiles')

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
  exe 'let @z = system(g:_python . " ~/.vim/scripts/buffers.py", @z)'
  exe 'silent $put z'

  if filereadable('.errors') && getfsize('.errors') > 0
    normal o== .errors
    exe 'silent r .errors'
    normal G
  endif
  if filereadable('.probatio-output.rb') && getfsize('.probatio-output.rb') > 0
    normal o== .probatio-output.rb
    exe 'silent r! ' . g:_ruby . ' ~/.vim/scripts/probatio.rb errors'
    normal G
  endif

  let vm = filereadable('.vimspec') && getfsize('.vimspec') > 0
  let tp = filereadable('.test-point') && getfsize('.test-point') > 0
    "
  if vm || tp
    normal o== .test-point / .vimspec
    if vm
      exe 'silent r! ' . g:_python . ' ~/.vim/scripts/cat.py .vimspec'
    end
    if tp
      exe 'silent r! ' . g:_python . ' ~/.vim/scripts/cat.py .test-point'
    end
    normal G
  end

  if filereadable('.vimmarks') && getfsize('.vimmarks') > 0
    normal o== .vimmarks
    exe 'silent r! ' . g:_python . ' ~/.vim/scripts/cat.py .vimmarks'
    normal G
  end

  if isdirectory('.git')
    normal o== git status
    exe 'r! ' . g:_python . ' ~/.vim/scripts/gitdiffstat.py 0'
    normal G
  endif

  if filereadable('.vimgrep') && getfsize('.vimgrep') > 0
    normal o== .vimgrep
    exe 'silent r .vimgrep'
    normal G
  endif

  if filereadable('.vimshorts') && getfsize('.vimshorts') > 0
    normal o== .vimshorts
    exe 'silent r! ' . g:_python . ' ~/.vim/scripts/cat.py .vimshorts'
    normal G
  end

  let cmd = g:_python . " ~/.vim/scripts/recentfiles.py " . winwidth(0)
  exe 'let @z=""'
  exe 'redir @z'
  exe 'silent oldfiles'
  exe 'redir END'
  exe 'let @z = system("' . cmd . '", @z)'
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

  let ln = get(a:, 1, -1)
  if ln > 0
    call feedkeys('' . ln . 'G')
  else
    call feedkeys(":call search('^[\.\/a-zA-Z0-9]', '')\r:echo\r")
      " go to first file
  end

  exe 'silent! %s/$//'
  exe 'silent! %s/\( [0-9]\+\)$/\1/'
  exe 'silent! %s/\\/\//g'

  setlocal syntax=buffers
  setlocal nomodifiable
  setlocal cursorline

  "nmap <buffer> o gF
  "nmap <buffer> <space> gF
  "nmap <buffer> <CR> gF
    "
  nnoremap <buffer> o :call JmOpenTreeFile()<CR>
  nnoremap <buffer> e :call JmOpenTreeFile('edit')<CR>
  nnoremap <buffer> <space> :call JmOpenTreeFile()<CR>
  nnoremap <buffer> <CR> :call JmOpenTreeFile()<CR>

  nnoremap <buffer> ga :call <SID>GitAddFile()<CR>
  nnoremap <buffer> gr :call <SID>GitUnstageFile()<CR>
  nnoremap <buffer> gu :call <SID>GitUnstageFile()<CR>

  nnoremap <buffer> d :call <SID>DeleteBuffer()<CR>

  nmap <buffer> s /

  nmap <buffer> bb :call search('^== buffers', '')<CR>:echo<CR>j
  nmap <buffer> ee :call search('^== \.errors', '')<CR>:echo<CR>j
  nmap <buffer> rr :call search('^== \.probatio-output', '')<CR>:echo<CR>j
  nmap <buffer> ii :call search('^== git status', '')<CR>:echo<CR>j
  nmap <buffer> tt :call search('^== git status', '')<CR>:echo<CR>j
  nmap <buffer> vv :call search('^== \.vimgrep', '')<CR>:echo<CR>j
  nmap <buffer> ss :call search('^== \.vimshorts', '')<CR>:echo<CR>j
  nmap <buffer> cc :call search('^== recent', '')<CR>:echo<CR>j
  nmap <buffer> mm :call search('^== \.vimmarks', '')<CR>:echo<CR>j
    " silently go to "^== xxx"

  nmap <buffer> a :call search('^== ', '')<CR>:echo<CR>0j
  nmap <buffer> A :call search('^== ', 'b')<CR>:call search('^== ', 'b')<CR>:echo<CR>j
    " silently go to next/previous "== "

  nmap <buffer> gl :call search('^== buffers', '')<CR>}k
    " silently go to last file in buffer
    " reminder type "}" to go to next blank line... See also "{", ")" and "("

  nnoremap <buffer> r :call <SID>ListFiles()<CR>
endfunction " ListFiles


command! -nargs=0 ListFiles :call <SID>ListFiles()
nnoremap <silent> <leader>b :call <SID>ListFiles()<CR>

nnoremap <silent> <leader>B :exe 'bdelete ' . join(range(1, bufnr('$')), ' ')<CR>:call <SID>ListFiles()<CR>

