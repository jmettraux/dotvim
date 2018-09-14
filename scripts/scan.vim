
function! s:OpenAtLine()

  let fn = matchstr(getline(2), '\v [^:].+')
  let ln = matchstr(getline(line('.')), '\v^\s*\d+')
  exe 'silent e ' . fn
  exe 'normal ' . ln . 'G'
endfunction " OpenAtLine

function! s:Scan()

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  "let path = expand("%:p") " expands into absolute file path
  let path = expand("%") " expands into relative file path
  let fname = expand("%:t")

  let fn = tempname() . '--' . fname . '.scanout'

  exe 'silent e ' . fn
  exe '%d_'
  exe "silent r! echo '== :Scan " . path . "'"
  exe 'r! echo ""'
  exe 'silent r! python ~/.vim/scripts/scan.py ' . path
  exe 'r! echo ""'

  setlocal syntax=scanout
  normal 4G
  silent write
  nnoremap <buffer> <silent> o :call <SID>OpenAtLine()<CR>
  nnoremap <buffer> <silent> <space> :call <SID>OpenAtLine()<CR>
  nnoremap <buffer> <silent> <CR> :call <SID>OpenAtLine()<CR>
endfunction " Scan
au BufRead *.scanout set filetype=scanout

command! -nargs=0 Scan :call <SID>Scan()
nnoremap <silent> <leader>k :call <SID>Scan()<CR>

