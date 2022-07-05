

function! s:Fgrep(rex)

  if &filetype == 'Fgrep' | return | endif
  if &filetype == 'Scan' | return | endif
  if &filetype == 'ListFiles' | return | endif

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let path = @%
  "let path = expand("%") " expands into relative file path

  let syn = JmScanSyn(path)
  if syn == '' | let syn = 'scanout_default' | endif

  let fn = '_f___' . JmNtr(path) . '__' . JmNtr(a:rex)

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
  "exe "silent r! echo '== :Fgrep " . path . "'"
  "exe "silent r! echo '==        " . a:rex . "'"
  exe "silent r! echo '== " . path . "'"
  exe "silent r! echo '== :Fgrep " . a:rex . "'"
  exe 'r! echo ""'
  exe 'silent r! /usr/bin/env python ~/.vim/scripts/fgrep.py ' . shellescape(path) . ' ' . shellescape(a:rex)
  exe 'r! echo ""'

  setlocal filetype=Fgrep
  exe 'setlocal syntax=' . syn
  setlocal nomodifiable
  normal 4G

  nnoremap <buffer> <silent> o :call JmScanOpenAtLine()<CR>
  nnoremap <buffer> <silent> <space> :call JmScanOpenAtLine()<CR>
  nnoremap <buffer> <silent> <CR> :call JmScanOpenAtLine()<CR>
endfunction " Fgrep

command! -nargs=1 Fgrep :call <SID>Fgrep(<q-args>)
command! -nargs=1 Fg :call <SID>Fgrep(<q-args>)
nnoremap <leader>h wb"zyw:exe ":call <SID>Fgrep('" . @z . "')"<CR>

