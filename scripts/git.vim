
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

      let pa = substitute(m0[1], '\v\s+$', '', '')
      let pa = substitute(pa, '\v\/', '\\/', 'g')
      let pa = substitute(pa, '\v\.', '\\.', 'g')
        "
      call search('^' . pa . ':[0-9]\+ ---', '')

      normal zz
      echo ''

      break

    elseif empty(m1) == 0

      let rt = systemlist('git rev-parse --show-toplevel')[0]
      let rt = fnamemodify(rt, ":p:.") " make path relative...
      if len(rt) > 0 && rt[-1:] != '/' | let rt = rt . '/' | endif

      let fn = rt . m1[1]
      let ln = str2nr(m1[2]) + nn - 1

      exe ':e +' . ln . ' ' . fn
      normal zz

      break
    endif

    let n = n - 1
    let nn = nn + empty(matchstr(l, '\v^-'))
  endwhile
endfunction " OpenFile


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

  let sha = a:sha
  let date = ''
  let title = ''
  if type(a:sha) == 3 | let sha = a:sha[0] | let date = a:sha[1] | let title = a:sha[2] | endif
    " help type, type 3 is List
  let title = title[0:35]

  let fn = '_c__' . sha . '__' . date . '__' . JmNtr(title)

  let bn = bufnr(fn)
  if bn > -1 | exe '' . bn . 'bwipeout!' | endif
    " close previous commit if any

  exe 'new | only'
    " | only makes it full window

  exe 'silent file ' . fn

  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  "setlocal nobuflisted
  "setlocal filetype=ListFiles

  if strlen(sha) > 1
    "exe 'silent r! echo ' . sha
    exe 'silent r! git diff --stat ' . sha . '^ ' . sha . ' | perl ~/.vim/scripts/regitdiffstat.pl'
    exe 'silent r! git show ' . sha . ' | perl ~/.vim/scripts/regitdiff.pl'
  else
    exe 'silent r! git diff --stat | perl ~/.vim/scripts/regitdiffstat.pl'
    exe 'silent r! git diff | perl ~/.vim/scripts/regitdiff.pl'
  endif

  setlocal syntax=gitdiff
  setlocal filetype=gitdiff
  setlocal nomodifiable

  exe 'normal 1G'

  nnoremap <buffer> <silent> a :call search('^.\+ ---+++', '')<CR>0zz
  nnoremap <buffer> <silent> A :call search('^.\+ ---+++', 'b')<CR>0zz
    " silently go to next file

  nnoremap <buffer> o :call <SID>OpenFile()<CR>
  nnoremap <buffer> <CR> :call <SID>OpenFile()<CR>
  nnoremap <buffer> <SPACE> :call <SID>OpenFile()<CR>

  nnoremap <buffer> <silent> q :bd<CR>
endfunction " OpenCommit

nnoremap <silent> <leader>d :call <SID>OpenCommit(0)<CR>

function! s:ExtractSha()

  let m = matchlist(getline('.'), '\v^[^a-fA-F0-9]+\zs([a-fA-F0-9]+) [^ ]+ ([0-9]+) [0-9]+ (\([^)]+\) )?(.+)$')
  if empty(m) == 1 | return [] | endif
  return [ m[1], m[2], m[4] ]
endfunction " ExtractSha

function! s:OpenGitLog(all)

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let fn = '_l___git_log'
  if a:all | let fn = fn . '___all' | endif

  let bn = bufnr(fn)
  if bn > -1 | exe '' . bn . 'bwipeout!' | endif
    " close previous GitLog if any

  exe 'new | only'
    " | only makes it full window
  exe 'silent file ' . fn
    " replace buffer name
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  "setlocal nobuflisted

  exe 'normal o== git log at ' . getcwd() . ''

  if a:all
    exe 'silent r! git log --graph --branches --pretty=format:"\%h \%an |\%ad \%d \%s" --date=iso-strict | /usr/bin/env python ~/.vim/scripts/regitlog.py'
  else
    exe 'silent r! git log --graph --pretty=format:"\%h \%an |\%ad \%d \%s" --date=iso-strict | /usr/bin/env python ~/.vim/scripts/regitlog.py'
  endif

  setlocal syntax=gitlog
  "setlocal filetype=gitlog
  setlocal nomodifiable

  exe 'normal 1G'
  exe 'normal 4G'

  nnoremap <buffer> <silent> o :call <SID>OpenCommit(<SID>ExtractSha())<CR>
  nnoremap <buffer> <silent> <CR> :call <SID>OpenCommit(<SID>ExtractSha())<CR>
  nnoremap <buffer> <silent> <SPACE> :call <SID>OpenCommit(<SID>ExtractSha())<CR>

  "nnoremap <buffer> <silent> c :call <SID>CheckoutCommit(<SID>ExtractSha())<CR>
  "nnoremap <buffer> <silent> M :call <SID>CheckoutCommit('master')<CR>

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

  let path = expand('%.')
  let ln = line('.')

  let fn = '_b___' . JmNtr(path)

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let bn = bufnr(fn)
  if bn > -1 | exe '' . bn . 'bwipeout!' | endif
    " close previous buffer if any

  exe 'new | only'
    " | only makes it full window
  exe 'silent file ' . fn
    " replace buffer name

  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  "setlocal nobuflisted

  exe 'silent r! /usr/bin/env python ~/.vim/scripts/gitblame.py ' . path

  setlocal syntax=gitblame
  setlocal nomodifiable

  exe 'normal ' . (ln + 1) . 'G'

  nmap <buffer> <leader>m <CR>
  nnoremap <buffer> <silent> <CR> :call <SID>OpenCommit(<SID>DetermineBlameSha())<CR>
  nnoremap <buffer> <silent> <SPACE> :call <SID>OpenCommit(<SID>DetermineBlameSha())<CR>

  nnoremap <buffer> <silent> q :bd<CR>
endfunction " OpenGitBlame

nnoremap <silent> <leader>m :call <SID>OpenGitBlame()<CR>
command! -nargs=0 Blame :call <SID>OpenGitBlame()


function! s:OpenFileFromDiff()

  let n = line('.')
  let nn = 0

  while n > 0

    let l = getline(n)
    "let me = matchlist(l, '\v^[@][@] -[,0-9]+ \+[,0-9]+ [@][@]')
    let me = matchlist(l, '\v^\+\+\+ b\/(.+)$')
    if empty(me) == 0
      echo me
      echo nn

      let rt = systemlist('git rev-parse --show-toplevel')[0]
      let rt = fnamemodify(rt, ":p:.") " make path relative...
      if len(rt) > 0 && rt[-1:] != '/' | let rt = rt . '/' | endif

      let fn = rt . me[1]
      echo fn

      let ln = nn - 1

      exe ':e +' . ln . ' ' . fn
      normal zz

      break
    endif

    let n = n - 1
    let nn = nn + empty(matchstr(l, '\v^-'))
  endwhile
endfunction " OpenFileFromDiff

function! s:OpenGitDiff(path)

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let fn = '_d___' . JmNtr(a:path)

  let bn = bufnr(fn)
  if bn > -1 | exe '' . bn . 'bwipeout!' | endif
    " close previous commit if any

  exe 'new | only'
    " | only makes it full window

  exe 'silent file ' . fn

  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  "setlocal nobuflisted
  "setlocal filetype=ListFiles

  exe 'silent r! git diff -U9999999 --no-color ' . a:path
  exe 'Clean'

  setlocal syntax=gitdiff
  setlocal filetype=gitdiff
  setlocal nomodifiable

  exe 'normal 1G'

"  nnoremap <buffer> <silent> a :call search('^.\+ ---+++', '')<CR>0zz
"  nnoremap <buffer> <silent> A :call search('^.\+ ---+++', 'b')<CR>0zz
"    " silently go to next file
"
  nnoremap <buffer> o :call <SID>OpenFileFromDiff()<CR>
  nnoremap <buffer> <CR> :call <SID>OpenFileFromDiff()<CR>
  nnoremap <buffer> <SPACE> :call <SID>OpenFileFromDiff()<CR>

  nnoremap <buffer> <silent> q :bd<CR>
endfunction " OpenGitDiff

nnoremap <silent> <leader>F :call <SID>OpenGitDiff(@%)<CR>


function! s:OpenGitCommits()

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let path = expand('%.')

  let fn = '_C___' . JmNtr(path)

  let bn = bufnr(fn)
  if bn > -1 | exe '' . bn . 'bwipeout!' | endif
    " close previous buffer if any

  exe 'new | only'
    " | only makes it full window
  exe 'silent file ' . fn
    " replace buffer name
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  "setlocal nobuflisted

  exe 'silent r! git log -p --follow ' . path
  exe 'Clean'

  setlocal syntax=gitdiff
  "setlocal filetype=gitdiff
  setlocal nomodifiable

  exe 'normal 1G'

  let b:path = path

  " TODO have way to open a full commit

endfunction " OpenGitCommits


function! s:OpenGitHistory()

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let path = expand('%.')
  let ln = line('.')

  let fn = '_h___' . JmNtr(path)

  let bn = bufnr(fn)
  if bn > -1 | exe '' . bn . 'bwipeout!' | endif
    " close previous buffer if any

  exe 'new | only'
    " | only makes it full window
  exe 'silent file ' . fn
    " replace buffer name
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  "setlocal nobuflisted

  exe 'normal o== version history for ' . path . ''

  exe 'silent r! git log --graph --pretty=format:"\%h \%an |\%ad \%d \%s" --date=iso-strict ' . path . ' | /usr/bin/env python ~/.vim/scripts/regitlog.py'

  setlocal syntax=gitlog
  "setlocal filetype=gitlog
  setlocal nomodifiable

  exe 'normal 1G'
  exe 'normal 4G'

  let b:path = path

  " open commit
  nnoremap <buffer> <silent> o :call <SID>OpenCommit(<SID>ExtractSha())<CR>

  " open version
  nnoremap <buffer> <silent> <CR> :call <SID>OpenVersion(b:path, <SID>ExtractSha())<CR>
  nnoremap <buffer> <silent> <SPACE> :call <SID>OpenVersion(b:path, <SID>ExtractSha())<CR>

  nnoremap <buffer> <silent> q :bd<CR>
endfunction " OpenGitHistory

command! -nargs=0 Gih :call <SID>OpenGitHistory()
nnoremap <silent> <leader>Y :call <SID>OpenGitHistory()<CR>

nnoremap <silent> <leader>S :call <SID>OpenGitCommits()<CR>


function s:OpenVersion(path, sha)

  if empty(a:sha) == 1 | return | endif

  let sha = a:sha[0]
  let date = a:sha[1]

  let path = systemlist('git rev-parse --show-prefix')[0] . a:path
    " this --show-prefix returns '' at the root...

  let fn = '_v__' . sha . '__' . date . '__' . JmNtr(path)

  let bn = bufnr(fn)
  if bn > -1 | exe '' . bn . 'bwipeout!' | endif
    " close previous GitLog if any

  exe 'new | only'
    " | only makes it full window
  exe 'silent file ' . fn
    " replace buffer name
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  "setlocal nobuflisted

  exe 'silent r! git show ' . sha . ':' . path

  if match(path, '\v\.rb$') > -1
    setlocal filetype=ruby
  elseif match(path, '\v\.js$') > -1
    setlocal filetype=javascript
  elseif match(path, '\v\.css$') > -1
    setlocal filetype=css
  elseif match(path, '\v\.scss$') > -1
    setlocal filetype=scss
  elseif match(path, '\v\.vim$') > -1
    setlocal filetype=vim
  endif

  setlocal nomodifiable

  exe 'normal 1G'

  nnoremap <buffer> <silent> q :bd<CR>
endfunction " OpenVersion

