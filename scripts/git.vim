
" git.vim - MIT licensed


"
" git diff

function! s:OpenFile()

  let n = line('.')
  let nn = 0

  while n > 0

    let l = getline(n)
    let m0 = matchlist(l, '\v^([^:]+) +\| +[0-9]+ \+*-*$')
    let m1 = matchlist(l, '\v^([^:]+):([0-9]+) ---\+\+\+$')

    if empty(m0) == 0

      "exe ':e ' . m0[1]

      call search('^' . m0[1] . ':', '')
      normal zz
      echo ''

      break

    elseif empty(m1) == 0

      let fn = m1[1]
      let ln = str2nr(m1[2]) + nn - 1
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
  exe 'silent file ==GitDiff'
    " replace buffer name
  exe 'setlocal buftype=nofile'
  exe 'setlocal bufhidden=hide'
  exe 'setlocal noswapfile'
  exe 'setlocal nobuflisted'
  "exe 'setlocal filetype=ListFiles'

  exe 'silent r! git diff --stat | perl ~/.vim/scripts/regitdiffstat.pl'
  exe 'silent r! git diff | perl ~/.vim/scripts/regitdiff.pl'

  exe 'normal 1Gdda'

  setlocal syntax=gitdiff

  nnoremap <buffer> <silent> a :call search('^.\+ ---+++', '')<CR>0zz
  nnoremap <buffer> <silent> A :call search('^.\+ ---+++', 'b')<CR>0zz
    " silently go to next file

  nnoremap <buffer> o :call <SID>OpenFile()<CR>
  nnoremap <buffer> <CR> :call <SID>OpenFile()<CR>
  nnoremap <buffer> <SPACE> :call <SID>OpenFile()<CR>

  nnoremap <buffer> <silent> q :bd<CR>
endfunction " OpenGitDiff

nnoremap <silent> <leader>d :call <SID>OpenGitDiff()<CR>


"
" git log

function! s:CheckoutCommit(sha)

  let s = system('git status -s -uno') " short, untracked: no
  if strlen(s) > 0 | echoerr "Current repo has uncommitted changes." | return | endif

  exe '!git checkout ' . a:sha
  exe ':bd'
endfunction " CheckoutCommit

function! s:OpenCommit(sha)

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  if bufnr('==GitCommit') > 0 | exe 'bwipeout! ==GitCommit' | endif
    " close previous GitLog if any

  exe 'new | only'
    " | only makes it full window
  exe 'silent file ==GitCommit'
    " replace buffer name
  exe 'setlocal buftype=nofile'
  exe 'setlocal bufhidden=hide'
  exe 'setlocal noswapfile'
  exe 'setlocal nobuflisted'
  "exe 'setlocal filetype=ListFiles'

  exe 'silent r! git show ' . a:sha . ' | perl ~/.vim/scripts/regitdiff.pl'

  setlocal syntax=gitdiff

  exe 'normal 1G'

  nnoremap <buffer> <silent> a :call search('^.\+ ---+++', '')<CR>0zz
  nnoremap <buffer> <silent> A :call search('^.\+ ---+++', 'b')<CR>0zz
    " silently go to next file

  nnoremap <buffer> o :call <SID>OpenFile()<CR>
  nnoremap <buffer> <CR> :call <SID>OpenFile()<CR>
  nnoremap <buffer> <SPACE> :call <SID>OpenFile()<CR>

  nnoremap <buffer> <silent> q :bd<CR>
endfunction " OpenCommit

function! s:OpenGitLog(all)

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  if bufnr('==GitLog') > 0 | exe 'bwipeout! ==GitLog' | endif
    " close previous GitLog if any

  exe 'new | only'
    " | only makes it full window
  exe 'silent file ==GitLog'
    " replace buffer name
  exe 'setlocal buftype=nofile'
  exe 'setlocal bufhidden=hide'
  exe 'setlocal noswapfile'
  exe 'setlocal nobuflisted'
  "exe 'setlocal filetype=ListFiles'

  " TODO git log --pretty=format:"%h %an |%ad %d %s" --date=iso
  if a:all
    exe 'silent r! git log --graph --oneline --abbrev-commit --decorate --branches | perl ~/.vim/scripts/regitlog.pl'
  else
    exe 'silent r! git log --graph --oneline --abbrev-commit --decorate | perl ~/.vim/scripts/regitlog.pl'
  endif

  setlocal syntax=gitlog

  exe 'normal 1G'

  nnoremap <buffer> <silent> o :call <SID>OpenCommit(matchstr(getline('.'), '\v^[^a-fA-F0-9]+\zs([a-fA-F0-9]+)'))<CR>
  nnoremap <buffer> <silent> <CR> :call <SID>OpenCommit(matchstr(getline('.'), '\v^[^a-fA-F0-9]+\zs([a-fA-F0-9]+)'))<CR>
  nnoremap <buffer> <silent> <SPACE> :call <SID>OpenCommit(matchstr(getline('.'), '\v^[^a-fA-F0-9]+\zs([a-fA-F0-9]+)'))<CR>
  nnoremap <buffer> <silent> c :call <SID>CheckoutCommit(matchstr(getline('.'), '\v^[^a-fA-F0-9]+\zs([a-fA-F0-9]+)'))<CR>
  nnoremap <buffer> <silent> M :call <SID>CheckoutCommit('master')<CR>

  nnoremap <buffer> <silent> q :bd<CR>
endfunction " OpenGitLog

command! -nargs=0 Gil :call <SID>OpenGitLog(0)
nnoremap <silent> <leader>l :call <SID>OpenGitLog(0)<CR>
nnoremap <silent> <leader>L :call <SID>OpenGitLog(1)<CR>


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
  exe 'silent file ==GitBlame'
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
  nnoremap <buffer> <silent> <CR> :call <SID>OpenCommit(<SID>DetermineBlameSha())<CR>
  nnoremap <buffer> <silent> <SPACE> :call <SID>OpenCommit(<SID>DetermineBlameSha())<CR>

  nnoremap <buffer> <silent> q :bd<CR>
endfunction " OpenGitBlame

nnoremap <silent> <leader>m :call <SID>OpenGitBlame()<CR>
command! -nargs=0 Blame :call <SID>OpenGitBlame()

