
function! s:FindFiles(fragment)

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let fn = tempname() . '--' . s:Ntr(a:fragment) . '.greprout'

  exe 'e ' . fn
  exe '%d_'
  exe "r! echo '== :FindFiles " . a:fragment . "'"
  "exe "Clean"
  exe 'r! echo ""'
  "exe 'r! find . -name "*' . a:fragment . '*"'
  exe 'r! find . -name "*" | grep ' . a:fragment
  exe 'r! echo ""'
  let g:groPattern = "'" . a:fragment . "'"
  setlocal syntax=greprout
  call feedkeys('4G')
  write
  nmap <buffer> o gF
  nmap <buffer> <space> gF
  nmap <buffer> <CR> gF
  "nmap <buffer> <leader>; gF
    " no, keep it for switching to alternate buffer
endfunction " FindFiles

command! -nargs=1 FindFiles :call <SID>FindFiles(<f-args>)
command! -nargs=1 VF :call <SID>FindFiles(<f-args>)

