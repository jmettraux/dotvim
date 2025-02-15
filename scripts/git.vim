
" git.vim - MIT licensed


"
" git diff

function! s:OpenFile(variant)

  let n = line('.')
  let nn = 0

  while n > 0

    let l = getline(n)
    let m0 = matchlist(l, '\v^([^:]+) +\| [MDA]\+[0-9]+-[0-9]+$')
    let m1 = matchlist(l, '\v^([^:]+):([0-9]+) ---\+\+\+ .+.$')

    if empty(m0) == 0 && a:variant == 'o'

      call JmOpenFile(m0[1], -1)

    elseif empty(m0) == 0

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

  "let bn = bufnr(fn)
  let bn = JmBufferNumber(fn)

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
  setlocal cursorline

  let w = winwidth(0)
  exe 'silent r! ' . g:_python . '~/.vim/scripts/gitdiffstat.py ' . sha
  if strlen(sha) > 1
    exe 'silent r! git show ' . sha .  ' | ' . g:_python . '~/.vim/scripts/regitdiff.py ' . w
  else
    exe 'silent r! git diff | ' . g:_python . '~/.vim/scripts/regitdiff.py ' . w
  endif

  setlocal syntax=gitdiff
  setlocal filetype=gitdiff
  setlocal nomodifiable

  exe 'normal 1G'

  nnoremap <buffer> <silent> a :call search('^.\+ ---+++', '')<CR>0zz
  nnoremap <buffer> <silent> A :call search('^.\+ ---+++', 'b')<CR>0zz
    " silently go to next file

  nnoremap <buffer> o :call <SID>OpenFile('o')<CR>
  nnoremap <buffer> <CR> :call <SID>OpenFile('cr')<CR>
  nnoremap <buffer> <SPACE> :call <SID>OpenFile('space')<CR>

  nnoremap <buffer> <silent> q :bd<CR>
endfunction " OpenCommit

command! -nargs=0 GitDelta :call <SID>OpenCommit(0)
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

  "let bn = bufnr(fn)
  let bn = JmBufferNumber(fn)

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

  let w = &columns

  exe 'normal o== git log at ' . getcwd() . ''

  if a:all
    exe 'silent r! git log --graph --branches --pretty=format:"\%h \%an |\%ad \%d \%s" --date=iso-strict | ' . g:_python . ' ~/.vim/scripts/regitlog.py ' . w
  else
    exe 'silent r! git log --graph --pretty=format:"\%h \%an |\%ad \%d \%s" --date=iso-strict | ' . g:_python . ' ~/.vim/scripts/regitlog.py ' . w
  endif

  setlocal syntax=gitlog
  "setlocal filetype=gitlog
  setlocal nomodifiable
  setlocal cursorline

  exe 'normal 1G'
  exe 'normal 4G'

  nnoremap <buffer> <silent> o :call <SID>OpenCommit(<SID>ExtractSha())<CR>
  nnoremap <buffer> <silent> <CR> :call <SID>OpenCommit(<SID>ExtractSha())<CR>
  nnoremap <buffer> <silent> <SPACE> :call <SID>OpenCommit(<SID>ExtractSha())<CR>

  "nnoremap <buffer> <silent> c :call <SID>CheckoutCommit(<SID>ExtractSha())<CR>
  "nnoremap <buffer> <silent> M :call <SID>CheckoutCommit('master')<CR>

  nnoremap <buffer> <silent> q :bd<CR>
endfunction " OpenGitLog

command! -nargs=0 GitLog :call <SID>OpenGitLog(0)
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

  "let bn = bufnr(fn)
  let bn = JmBufferNumber(fn)

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
  setlocal cursorline

  exe 'silent r! ' . g:_python . ' ~/.vim/scripts/gitblame.py ' . path

  setlocal syntax=gitblame
  setlocal nomodifiable

  exe 'normal ' . (ln + 1) . 'G'

  nmap <buffer> <leader>m <CR>
  nnoremap <buffer> <silent> <CR> :call <SID>OpenCommit(<SID>DetermineBlameSha())<CR>
  nnoremap <buffer> <silent> <SPACE> :call <SID>OpenCommit(<SID>DetermineBlameSha())<CR>

  nnoremap <buffer> <silent> q :bd<CR>
endfunction " OpenGitBlame

"nnoremap <silent> <leader>m :call <SID>OpenGitBlame()<CR>
command! -nargs=0 GitBlame :call <SID>OpenGitBlame()


function! s:OpenFileFromDiff()

  let rt = systemlist('git rev-parse --show-toplevel')[0]
  let rt = fnamemodify(rt, ":p:.") " make path relative...
  if len(rt) > 0 && rt[-1:] != '/' | let rt = rt . '/' | endif
  let fn = rt . matchlist(getline(2), '\v b\/(.+)$')[1]

  let l = getline('.')
  let m = matchlist(getline('.'), '\v^ *(\d+)')
  if empty(m) == 0
    exe ':e +' . m[1] . ' ' . fn
    normal zz
  endif
endfunction " OpenFileFromDiff

function! s:OpenGitDiff(path)

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let ln = line('.')

  let fn = '_d___' . JmNtr(a:path)

  "let bn = bufnr(fn)
  let bn = JmBufferNumber(fn)

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
  setlocal cursorline

  exe 'silent r! ' . g:_python . ' ~/.vim/scripts/opengitdiff.py ' . a:path
  exe 'Clean'

  exe 'setlocal syntax=' . JmDetermineSyntax(a:path)
  "exe 'setlocal filetype=' . JmDetermineSyntax(a:path)
    "
  hi! ColorColumn ctermbg=16
  hi! gsdHeader cterm=NONE ctermfg=238 ctermbg=black
  hi! gsdLineNumber cterm=NONE ctermfg=238 ctermbg=black
  hi! gsdPlus cterm=NONE ctermfg=green ctermbg=black
  hi! gsdMinus cterm=NONE ctermfg=red ctermbg=black
  syn region gsdHeader start='\v^diff --git a\/' end='\v\d [@][@]$' containedin=ALL
  "syn match gsdLineNumber /\v^ *\d+/ containedin=ALL
  syn region gsdLineNumber start='\%1c' end='\%6c' containedin=ALL
  syn region gsdPlus start='\%7c+' end='\%8c' containedin=ALL
  syn region gsdMinus start='\%7c\-' end='\%8c' containedin=ALL

  setlocal nomodifiable
    "
    " TODO fix that!!!

  normal 1G
  let n = 0
  let nn = -1
  let mn = line('$') + 1
  while n < mn
    let n = n + 1
    let l = getline(n)
    if nn < 0
      if len(matchstr(l, '\v^[@][@] [-+0-9, ]+ [@][@]$')) > 0 | let nn = 0 | endif
    else
      if len(matchstr(l, '\v^-')) == 0 | let nn = nn + 1 | endif
    endif
    if nn >= ln | break | endif
  endwhile
  exe 'normal ' . n . 'G'

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

  "let bn = bufnr(fn)
  let bn = JmBufferNumber(fn)

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

  "let bn = bufnr(fn)
  let bn = JmBufferNumber(fn)

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
  setlocal cursorline

  exe 'normal o== version history for ' . path . ''

  let w = &columns

  exe 'silent r! git log --graph --pretty=format:"\%h \%an |\%ad \%d \%s" --date=iso-strict ' . path . ' | ' . g:_python . ' ~/.vim/scripts/regitlog.py ' . w

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

"command! -nargs=0 Gih :call <SID>OpenGitHistory()
"nnoremap <silent> <leader>Y :call <SID>OpenGitHistory()<CR>
command! -nargs=0 GitHistory :call <SID>OpenGitHistory()

nnoremap <silent> <leader>S :call <SID>OpenGitCommits()<CR>


function! s:OpenVersion(path, sha)

  if empty(a:sha) == 1 | return | endif

  let sha = a:sha[0]
  let date = a:sha[1]

  let path = systemlist('git rev-parse --show-prefix')[0] . a:path
    " this --show-prefix returns '' at the root...

  let fn = '_v__' . sha . '__' . date . '__' . JmNtr(path)

  "let bn = bufnr(fn)
  let bn = JmBufferNumber(fn)

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


command! -nargs=0 GitPush :! git push<CR>
command! -nargs=0 GitStatus :! git status<CR>
command! -nargs=0 GitCommit :! git commit %:p<CR>
command! -nargs=0 GitCommitAll :! git commit -a<CR>


function! s:FileGitDiff()

  let fp = expand('%:p')
  let fn = '_gdf__' . JmNtr(fp)
  let bn = JmBufferNumber(fn)

  let w = winwidth(0)

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

  let l = split(system('wc -l ' . shellescape(fp)))[0]

  exe 'silent r! git diff -U' . l . ' ' . fp . ' | ' . g:_python . '~/.vim/scripts/regitdiff.py ' . w

  setlocal syntax=gitdiff
  setlocal filetype=gitdiff
  setlocal nomodifiable

  exe 'normal 1G'

  nnoremap <buffer> o :call <SID>OpenFile('o')<CR>
  nnoremap <buffer> <CR> :call <SID>OpenFile('cr')<CR>
  nnoremap <buffer> <SPACE> :call <SID>OpenFile('space')<CR>

  nnoremap <buffer> <silent> q :bd<CR>
endfunction " FileGitDiff

"nnoremap <silent> <leader>i :call <SID>FileGitDiff()<CR>
command! -nargs=0 GitDiff :call <SID>FileGitDiff()

