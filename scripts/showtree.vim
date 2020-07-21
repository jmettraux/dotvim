
function! JmShowTree(start)

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let fn = '_t___' . JmNtr(a:start)

  let bn = bufnr(fn)
  if bn > -1 | exe '' . bn . 'bwipeout!' | endif
    " close previous GitLog if any

  exe 'new | only'
    " | only makes it full window

  exe 'silent file ' . fn

  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile

  exe '%d'
    " delete all the lines
  normal O
  exe 'silent r! /usr/bin/env python ~/.vim/scripts/tree.py ' . a:start
  exe 'silent %s/\v\[ *([0-9.]+[KMGTPE]?)\]  (.+)$/\2 \1/e'
  exe 'silent %s/\v\* / /ge'
  exe 'silent %s/\\ / /ge'
    " e to silent when no pattern match
  normal 1G
  setlocal syntax=showtreeout
  setlocal nomodifiable

  nnoremap <buffer> o :call JmOpenTreeFile()<CR>
  nnoremap <buffer> <space> :call JmOpenTreeFile()<CR>
  nnoremap <buffer> <CR> :call JmOpenTreeFile()<CR>

  nnoremap <buffer> C :call JmCopyTreeFile()<CR>
  nnoremap <buffer> D :call JmDeleteTreeFile()<CR>
  nnoremap <buffer> R :call JmRenameTreeFile()<CR>
  nnoremap <buffer> M :call JmMoveTreeFile()<CR>
  nnoremap <buffer> ga :call JmGitAddTreeFile()<CR>
  nnoremap <buffer> p :exe "echo JmDetermineTreePath()"<CR>
  nnoremap <buffer> r :call JmReloadTree(0)<CR>

  nmap <buffer> v /

  nnoremap <buffer> <silent> a j:call search('\v [^ ]+\/', '')<CR>0zz
  nnoremap <buffer> <silent> A :call search('\v [^ ]+\/', 'b')<CR>0zz

  nnoremap <buffer> <silent> q :bd<CR>
endfunction " ShowTree

command! -nargs=1 -complete=dir Vt :call JmShowTree(<f-args>)
"au BufRead *.showtreeout set filetype=showtreeout

"au VimLeave * :!rm -f .*.showtreeout
  " remove all the local .showtreeout files upon leaving Vim


function! s:ShowSourceTree()

  if !empty(glob("lib"))
    call JmShowTree('lib')
  elseif !empty(glob("src"))
    call JmShowTree('src')
  endif
endfunction " ShowSourceTree
command! -nargs=0 Vs :call <SID>ShowSourceTree()
nnoremap <silent> <leader>s :call <SID>ShowSourceTree()<CR>

function! s:ShowTestTree()

  if !empty(glob("spec"))
    call JmShowTree('spec')
  elseif !empty(glob("test"))
    call JmShowTree('test')
  endif
endfunction " ShowTestTree
command! -nargs=0 Vtt :call <SID>ShowTestTree()
command! -nargs=0 Vst :call <SID>ShowTestTree()
command! -nargs=0 Vc :call <SID>ShowTestTree()


function! JmDetermineTreePath()

  let l = getline('.')

  let m = matchlist(l, '\v\=\= (.+)$')
  if empty(m) != 1 | return '' | endif

  let m = matchlist(l, '\v  \/ (["''].+)$')
  if empty(m) == 1 | let m = matchlist(l, '\v  \/ ''([^'']+)'' +(.+)$') | endif
  if empty(m) != 1 | return '' | endif

  return JmDetermineTreePathAndLine()[0]
endfunction " JmDetermineTreePath


function! JmCopyTreeFile()

  let path = JmDetermineTreePath()
  if empty(path) | return 0 | endif
  if isdirectory(path) | return 0 | endif

  call system('cp ' . path . ' ' . path . '.copy')

  call JmReloadTree(1)
endfunction " JmCopyTreeFile


function! JmDeleteTreeFile()

  let path = JmDetermineTreePath()
  if empty(path) | return 0 | endif
  if isdirectory(path) | return 0 | endif

  if confirm('Delete ' . path . ' ?', "&No\n&yes") == 1 | return 0 | endif

  let cmd = 'rm'
  if isdirectory('.git') && empty(system('git ls-files ' . path)) == 0
    let cmd = 'git rm -f'
  endif

  call system(cmd . ' ' . path)
  call JmReloadTree(0)
endfunction " JmDeleteTreeFile


  " Unlike JmMoveTreeFile() is local to its dir and doesn't defer to Git
  "
function! JmRenameTreeFile()

  let path = JmDetermineTreePath()
  if empty(path) | return 0 | endif
  if isdirectory(path) | return 0 | endif

  let p = fnamemodify(path, ':h')
  let n = fnamemodify(path, ':t')
  let n1 = trim(input('Rename to: ', n))

  if empty(n1) | return 0 | endif
  if n1 == n | return 0 | endif

  call system('mv ' . p . '/' . n . ' ' . p . '/' . n1)

  call JmReloadTree(0)
endfunction " JmRenameTreeFile


function! JmMoveTreeFile()

  let path = JmDetermineTreePath()
  if empty(path) | return 0 | endif
  if isdirectory(path) | return 0 | endif

  let p1 = trim(input('Move to: ', path, 'file'))
    " CTRL-C to interrupt

  if empty(p1) | return 0 | endif

  let cmd = 'mv'
  if isdirectory('.git') && empty(system('git ls-files ' . path)) == 0
    let cmd = 'git mv'
  endif

  call system(cmd . ' ' . path . ' ' . p1)

  call JmReloadTree(0)
endfunction " JmMoveTreeFile


function! JmGitAddTreeFile()

  let path = JmDetermineTreePath()
  if empty(path) | return 0 | endif

  call system('git add ' . path)

  call JmReloadTree(0)

  echo 'Added ' . path . ' to Git'
endfunction " JmGitAddTreeFile


function! JmReloadTree(dline)

  let l = line('.') + a:dline
  call JmShowTree(getline(2))
  call feedkeys(l . 'G')
endfunction " JmReloadTree

