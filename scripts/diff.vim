
"
" DiffFrom and DiffTo

function! s:DiffFrom(toPath)

  if &filetype == 'diff' | return | endif
  if &filetype == 'Scan' | return | endif
  if &filetype == 'Fgrep' | return | endif
  if &filetype == 'ListFiles' | return | endif

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let a = expand(a:toPath)
  let b = expand('%.')

  exe ':%d'
  exe 'silent r! /usr/bin/env python ~/.vim/scripts/diff.py ' . shellescape(a) . ' ' . shellescape(b)
endfunction

function! s:DiffTo(toPath)

  if &filetype == 'diff' | return | endif
  if &filetype == 'Scan' | return | endif
  if &filetype == 'Fgrep' | return | endif
  if &filetype == 'ListFiles' | return | endif

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let a = expand('%.')
  let b = expand(a:toPath)

  exe ':%d'
  exe 'silent r! /usr/bin/env python ~/.vim/scripts/diff.py ' . shellescape(a) . ' ' . shellescape(b)
endfunction

command! -nargs=1 -complete=file DiffFrom :call <SID>DiffFrom(<f-args>)
command! -nargs=1 -complete=file DiffTo :call <SID>DiffTo(<f-args>)


"
" GitDiffFrom and GitDiffTo

function! s:GitDiff(dir, toPath)

  if &filetype == 'diff' | return | endif
  if &filetype == 'Scan' | return | endif
  if &filetype == 'Fgrep' | return | endif
  if &filetype == 'ListFiles' | return | endif

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let a = (a:dir == 'from') ? expand(a:toPath) : expand('%.')
  let b = (a:dir == 'from') ? expand('%.') : expand(a:toPath)

  let fn = '_gdiff__' . a:dir . '___' . JmNtr(a) . '___' . JmNtr(b)

  let bn = bufnr(fn)
  if bn > -1 | exe '' . bn . 'bwipeout!' | endif
    " close previous buffer if any

  exe 'new | only'
    " | only makes it full window
  exe 'silent file ' . fn
    " replace buffer name

  setlocal buftype=nofile
  "setlocal bufhidden=hide
  setlocal noswapfile
  "setlocal nobuflisted

  exe 'silent r! /usr/local/bin/git diff ' . shellescape(a) . ' ' . shellescape(b)
  exe 'silent %s/\v\s*$//'
  nohlsearch

  setlocal filetype=diff
  "exe 'setlocal syntax=' . syn
  setlocal nomodifiable
  normal 1G
endfunction

command! -nargs=1 -complete=file GitDiffFrom :call <SID>GitDiff('from', <f-args>)
command! -nargs=1 -complete=file GitDiffTo :call <SID>GitDiff('to', <f-args>)

