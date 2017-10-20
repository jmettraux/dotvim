
function! s:OpenTreeFile()

  let n = line('.')
  let last = '................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................'
  let elts = []

  while n > 0
    let l = getline(n)
    let m = matchlist(l, '\v^([│├─└  ]+) (.+)$')
    if empty(m) == 1 | let elts = [ l ] + elts | break | endif
    let left = substitute(m[1], '└', '├', 'g')
    let right = m[2]
    let n = n - 1
    if left == last | continue | endif
    if len(left) > len(last) | continue | endif
    let last = left
    let elts = [ right ] + elts
  endwhile

  exe 'e ' . join(elts, '/')
endfunction " OpenTreeFile

function! s:ShowTree(start)

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let fn = tempname() . '--' . JmNtr(a:start) . '.showtreeout'

  exe 'e ' . fn

  "exe 'silent r! tree -i -f -F ' . a:start
  normal O
  exe 'silent r! tree -F ' . a:start
  normal 1G
  setlocal syntax=showtreeout
  write

  "nmap <buffer> o gF
  "nmap <buffer> <space> gF
  "nmap <buffer> <CR> gF
  nnoremap <buffer> o :call <SID>OpenTreeFile()<CR>
  nnoremap <buffer> <space> :call <SID>OpenTreeFile()<CR>
  nnoremap <buffer> <CR> :call <SID>OpenTreeFile()<CR>

  nmap <buffer> v /

  nnoremap <buffer> <silent> a j:call search('\v [^ ]+\/', '')<CR>0zz
  nnoremap <buffer> <silent> A :call search('\v [^ ]+\/', 'b')<CR>0zz

  nnoremap <buffer> <silent> q :bd<CR>
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
nnoremap <silent> <leader>s :call <SID>ShowSourceTree()<CR>

function! s:ShowTestTree()

  if !empty(glob("spec"))
    exe ':call <SID>ShowTree("spec")'
  elseif !empty(glob("test"))
    exe ':call <SID>ShowTree("test")'
  endif
endfunction " ShowTestTree
command! -nargs=0 Vtt :call <SID>ShowTestTree()
command! -nargs=0 Vst :call <SID>ShowTestTree()
command! -nargs=0 Vc :call <SID>ShowTestTree()

