
function! s:ShowTree(start)

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let fn = '__' . JmNtr(a:start) . '.showtreeout'

  let bn = bufnr(fn)
  if bn > -1 | exe '' . bn . 'bwipeout!' | endif
    " close previous GitLog if any

  exe 'new | only'
    " | only makes it full window

  exe 'silent file ' . fn

  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile

  exe '%d'
    " delete all the lines
  normal O
  exe 'silent r! tree -hF ' . a:start
  "exe 'silent %s/\v\[ *([0-9.]+[KMGTPE]?)\]  //e'
  exe 'silent %s/\v\[ *([0-9.]+[KMGTPE]?)\]  (.+)$/\2 \1/e'
  exe 'silent %s/\v\* / /ge'
  exe 'silent %s/\\ / /ge'
    " e to silent when no pattern match
  normal 1G
  setlocal syntax=showtreeout
  setlocal nomodifiable

  nnoremap <buffer> o :call JmOpenTreeFile()<CR>
  nnoremap <buffer> <space> :call JmOpenTreeFile()<CR>
  nnoremap <buffer> <CR> :call JmOpenTreeFile()<CR>

  nmap <buffer> v /

  nnoremap <buffer> <silent> a j:call search('\v [^ ]+\/', '')<CR>0zz
  nnoremap <buffer> <silent> A :call search('\v [^ ]+\/', 'b')<CR>0zz

  nnoremap <buffer> <silent> q :bd<CR>
endfunction " ShowTree

command! -nargs=1 -complete=dir Vt :call <SID>ShowTree(<f-args>)
"au BufRead *.showtreeout set filetype=showtreeout

"au VimLeave * :!rm -f .*.showtreeout
  " remove all the local .showtreeout files upon leaving Vim


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

