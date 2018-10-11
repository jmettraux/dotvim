
function! s:OpenAtLine()

  let fn = matchstr(getline(2), '\v [^:].+')
  let ln = matchstr(getline(line('.')), '\v^\s*\d+')
  exe 'silent e ' . fn
  exe 'normal ' . ln . 'G'
endfunction " OpenAtLine

function! s:Scan()

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  ""let path = expand("%:p") " expands into absolute file path
  let path = expand("%") " expands into relative file path
  "let fname = expand("%:t")

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
  exe 'silent r! python ~/.vim/scripts/scan.py ' . path
  exe 'r! echo ""'

  if path =~ "_spec\.rb$"
    setlocal syntax=scanout_ruby_spec
  elseif path =~ "\.rb$"
    setlocal syntax=scanout_ruby
  elseif path =~ "\.py$"
    setlocal syntax=scanout_python
  elseif path =~ "\.js$"
    setlocal syntax=scanout_javascript
  else
    setlocal syntax=scanout
  endif
  setlocal nomodifiable
  normal 4G

  nnoremap <buffer> <silent> o :call <SID>OpenAtLine()<CR>
  nnoremap <buffer> <silent> <space> :call <SID>OpenAtLine()<CR>
  nnoremap <buffer> <silent> <CR> :call <SID>OpenAtLine()<CR>
endfunction " Scan
"au BufRead *.scanout set filetype=scanout

command! -nargs=0 Scan :call <SID>Scan()
nnoremap <silent> <leader>k :call <SID>Scan()<CR>

