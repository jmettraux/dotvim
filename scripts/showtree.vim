
function! s:ShowTree(start)

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let fn = tempname() . '--' . JmNtr(a:start) . '.showtreeout'

  exe 'e ' . fn

  exe 'silent r! tree -i -f -F ' . a:start
  "exe 'silent g/\/$/d'
  normal 1GddA/
  setlocal syntax=showtreeout
  write

  nmap <buffer> o gF
  nmap <buffer> <space> gF
  nmap <buffer> <CR> gF

  nmap <buffer> v /
endfunction " ShowTree

command! -nargs=1 -complete=dir Vt :call <SID>ShowTree(<f-args>)
au BufRead *.showtreeout set filetype=showtreeout


function! s:ShowSourceTree()

  if !empty(glob("lib"))
    exe ':call <SID>ShowTree("lib")'
  elseif !empty(glob("src"))
    exe ':call <SID>ShowTree("src")'
  endif
endfunction " ShowSourceTree
command! -nargs=0 Vs :call <SID>ShowSourceTree()

