
"
" DiffFrom and DiffTo

function! s:DiffPy(dir, path)

  if &filetype == 'diff' | return | endif
  if &filetype == 'Scan' | return | endif
  if &filetype == 'Fgrep' | return | endif
  if &filetype == 'ListFiles' | return | endif

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let a = (a:dir == 'from') ? expand(a:path) : expand('%.')
  let b = (a:dir == 'from') ? expand('%.') : expand(a:path)

  exe ':%d'
  exe 'silent r! ' . g:_python . ' ~/.vim/scripts/diff.py ' . shellescape(a) . ' ' . shellescape(b)
endfunction

command! -nargs=1 -complete=file DiffFrom :call <SID>DiffPy('from', <f-args>)
command! -nargs=1 -complete=file DiffTo :call <SID>DiffPy('to', t<f-args>)


"
" GitDiffFrom and GitDiffTo

function! s:GitDiff(dir, path)

  if &filetype == 'diff' | return | endif
  if &filetype == 'Scan' | return | endif
  if &filetype == 'Fgrep' | return | endif
  if &filetype == 'ListFiles' | return | endif

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let d = expand('%.')
  let p = expand(a:path)
  let a = (a:dir == 'from') ? p : d
  let b = (a:dir == 'from') ? d : p

  let fn = '_gdiff__' . a:dir . '___' . JmNtr(a) . '___' . JmNtr(b)

  "let bn = bufnr(fn)
  let bn = JmBufferNumber(fn)

  if bn > -1 | exe '' . bn . 'bwipeout!' | endif
    " close previous buffer if any

  exe 'new | only'
    " | only makes it full window
  exe 'silent file ' . fn
    " replace buffer name

  setlocal filetype=diff
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  "setlocal nobuflisted

  if filereadable(p)
    exe 'silent r! /usr/local/bin/git diff ' . shellescape(a) . ' ' . shellescape(b)
  else
    exe 'silent r! /usr/local/bin/git diff ' . a:path . ' -- ' . d
  endif

  exe 'silent %s/\v\s*$//'
  nohlsearch

  setlocal syntax=diff
  "setlocal nomodifiable
  normal 1G
endfunction

command! -nargs=1 -complete=file GitDiffFrom :call <SID>GitDiff('from', <f-args>)
command! -nargs=1 -complete=file GitDiffTo :call <SID>GitDiff('to', <f-args>)

