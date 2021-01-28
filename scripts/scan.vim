
function! JmScanSyn(path)

  if a:path =~ "_spec\.rb$" | return 'scanout_ruby_spec' | endif
  if a:path =~ "\.rb$" | return 'scanout_ruby' | endif
  "if a:path =~ "\.py$" | return 'scanout_python' | endif
  if a:path =~ "\.js$" | return 'scanout_javascript' | endif
  if a:path =~ "\.md$" | return 'scanout_markdown' | endif
  return ''
endfunction " JmScanSyn

function! JmScanOpenAtLine()

  let fn = matchstr(getline(2), '\v [^:].+')
  let ln = matchstr(getline(line('.')), '\v^\s*\d+')
  exe 'silent e ' . fn
  exe 'normal ' . ln . 'G'
endfunction " JmScanOpenAtLine

function! s:Scan()

  if &filetype == 'Scan' | return | endif
  if &filetype == 'ListFiles' | return | endif

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  ""let path = expand("%:p") " expands into absolute file path
  let path = expand("%") " expands into relative file path
  "let fname = expand("%:t")

  let syn = JmScanSyn(path)
  if syn == '' | echoerr "don't know how to scan " . path | return | endif

  let fn = '_k___' . JmNtr(path)

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

  exe '%d_'
  exe "silent r! echo '== :Scan " . path . "'"
  exe 'r! echo ""'
  exe 'silent r! /usr/bin/env python ~/.vim/scripts/scan.py ' . path
  exe 'r! echo ""'

  setlocal filetype=Scan
  exe 'setlocal syntax=' . syn
  setlocal nomodifiable
  normal 4G

  nnoremap <buffer> <silent> o :call JmScanOpenAtLine()<CR>
  nnoremap <buffer> <silent> <space> :call JmScanOpenAtLine()<CR>
  nnoremap <buffer> <silent> <CR> :call JmScanOpenAtLine()<CR>
endfunction " Scan

command! -nargs=0 Scan :call <SID>Scan()
nnoremap <silent> <leader>k :call <SID>Scan()<CR>

