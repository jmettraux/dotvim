
" git.vim - MIT licensed


"
" git diff

function! s:OpenFile()

  let n = line('.')
  let nn = 0

  while n > 0

    let l = getline(n)
    let m = matchlist(l, '\v^([^:]+):([0-9]+) ---\+\+\+$')

    if empty(m) == 0

      let fn = m[1]
      let ln = str2nr(m[2]) + nn - 1
      exe ':e +' . ln . ' ' . fn
      normal zz

      break
    endif

    let n = n - 1
    let nn = nn + empty(matchstr(l, '\v^-'))
  endwhile
endfunction " OpenFile


function! s:OpenGitDiff()

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  if bufnr('==GitDiff') > 0 | exe 'bwipeout! ==GitDiff' | endif
    " close previous GitDiff if any

  exe 'new | only'
    " | only makes it full window
  exe 'file ==GitDiff'
    " replace buffer name
  exe 'setlocal buftype=nofile'
  exe 'setlocal bufhidden=hide'
  exe 'setlocal noswapfile'
  exe 'setlocal nobuflisted'
  "exe 'setlocal filetype=ListFiles'

  exe 'silent r! git diff | perl ~/.vim/scripts/regitdiff.pl'

  setlocal syntax=gitdiff

  nmap <buffer> a :call search('^.\+ ---+++', '')<CR>:echo<CR>0
  nmap <buffer> A :call search('^.\+ ---+++', 'b')<CR>:echo<CR>0
    " silently go to next file

  exe 'normal 1Gdda'

  nmap <buffer> o :call <SID>OpenFile()<CR>
  nmap <buffer> <SPACE> :call <SID>OpenFile()<CR>
  nmap <buffer> <CR> :call <SID>OpenFile()<CR>
endfunction " OpenGitDiff

nnoremap <silent> <leader>d :call <SID>OpenGitDiff()<CR>


"
" git log

function! s:OpenCommit(sha)

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  if bufnr('==GitCommit') > 0 | exe 'bwipeout! ==GitCommit' | endif
    " close previous GitLog if any

  exe 'new | only'
    " | only makes it full window
  exe 'file ==GitCommit'
    " replace buffer name
  exe 'setlocal buftype=nofile'
  exe 'setlocal bufhidden=hide'
  exe 'setlocal noswapfile'
  exe 'setlocal nobuflisted'
  "exe 'setlocal filetype=ListFiles'

  exe 'silent r! git show ' . a:sha . ' | perl ~/.vim/scripts/regitdiff.pl'

  setlocal syntax=gitdiff

  exe 'normal 1G'
endfunction " OpenCommit

function! s:OpenGitLog()

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  if bufnr('==GitLog') > 0 | exe 'bwipeout! ==GitLog' | endif
    " close previous GitLog if any

  exe 'new | only'
    " | only makes it full window
  exe 'file ==GitLog'
    " replace buffer name
  exe 'setlocal buftype=nofile'
  exe 'setlocal bufhidden=hide'
  exe 'setlocal noswapfile'
  exe 'setlocal nobuflisted'
  "exe 'setlocal filetype=ListFiles'

  exe 'silent r! git log --graph --oneline --abbrev-commit --decorate | perl ~/.vim/scripts/regitlog.pl'

  setlocal syntax=gitlog

  exe 'normal 1G'

  nmap <buffer> <CR> :call <SID>OpenCommit(matchstr(getline('.'), '\v^\* \zs([a-fA-F0-9]+)'))<CR>
endfunction " OpenGitLog

command! -nargs=0 Gil :call <SID>OpenGitLog()
nnoremap <silent> <leader>l :call <SID>OpenGitLog()<CR>


"
" git blame

function! s:DetermineBlameSha()

  let ln = line('.')

  while ln > 0
    let m = matchstr(getline(ln), '\v^[a-fA-F0-9]+')
    if empty(m) == 0 | return m | end
    let ln = ln - 1
  endwhile

  return -1
endfunction " DetermineBlameSha

function! s:OpenGitBlame()

  let fn = expand('%.')
  let ln = line('.')

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  if bufnr('==GitBlame') > 0 | exe 'bwipeout! ==GitBlame' | endif
    " close previous GitBlame if any

  exe 'new | only'
    " | only makes it full window
  exe 'file ==GitBlame'
    " replace buffer name
  exe 'setlocal buftype=nofile'
  exe 'setlocal bufhidden=hide'
  exe 'setlocal noswapfile'
  exe 'setlocal nobuflisted'
  "exe 'setlocal filetype=ListFiles'

  exe 'silent r! git blame ' . fn . ' | perl ~/.vim/scripts/regitblame.pl'

  exe 'g/^$/d_'

  setlocal syntax=gitblame

  exe 'normal ' . ln . 'G'

  nmap <buffer> <leader>m <CR>
  nmap <buffer> <CR> :call <SID>OpenCommit(<SID>DetermineBlameSha())<CR>
  nmap <buffer> <SPACE> :call <SID>OpenCommit(<SID>DetermineBlameSha())<CR>
endfunction " OpenGitBlame

nnoremap <silent> <leader>m :call <SID>OpenGitBlame()<CR>
command! -nargs=0 Blame :call <SID>OpenGitBlame()

