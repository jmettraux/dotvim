

"function! JmFuzzer(start)
function! JmFuzzer()

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  "let fn = '_F___' . JmNtr(a:start)
  let fn = '_F___'

  "let bn = bufnr(fn)
  let bn = JmBufferNumber(fn)

  if bn > -1 | exe '' . bn . 'bwipeout!' | endif
    " close previous GitLog if any

  exe 'new | only'
    " | only makes it full window

  exe 'silent file ' . fn

  setlocal buftype=nofile
  "setlocal bufhidden=hide
  setlocal noswapfile
  setlocal cursorline

  let arg = '"' . getline(1) . '"'
  echo arg
  "exe '2,$d'
  "normal o
  "exe 'silent r! /usr/bin/env python ~/.vim/scripts/fuzzer.py ' . arg
  "exe 'silent g/^The system cannot find the path specified\./d'
  "exe 'silent %s/\v\[ *([0-9.]+[KMGTPE]?)\]  (.+)$/\2 \1/e'
  "exe 'silent %s/\v\* / /ge'
  "exe 'silent %s/\\ / /ge'
    " e to silent when no pattern match
  "normal 2G
  "setlocal syntax=showtreeout
  "setlocal nomodifiable

"  nnoremap <buffer> o :call JmOpenTreeFile()<CR>
"  nnoremap <buffer> e :call JmOpenTreeFile('edit')<CR>
"  nnoremap <buffer> <space> :call JmOpenTreeFile()<CR>
"  nnoremap <buffer> <CR> :call JmOpenTreeFile()<CR>
"
"  nnoremap <buffer> C :call JmCopyTreeFile()<CR>
"  nnoremap <buffer> D :call JmDeleteTreeFile()<CR>
"  nnoremap <buffer> R :call JmRenameTreeFile()<CR>
"  nnoremap <buffer> M :call JmMoveTreeFile()<CR>
"  nnoremap <buffer> ga :call JmGitAddTreeFile()<CR>
"  nnoremap <buffer> gr :call JmGitUnaddTreeFile()<CR>
"  nnoremap <buffer> gu :call JmGitUnaddTreeFile()<CR>
"  nnoremap <buffer> p :exe "echo JmDetermineTreePath()"<CR>
"  nnoremap <buffer> r :call JmReloadTree(0)<CR>
"  nnoremap <buffer> T :call JmGitCommitTreeFile()<CR>
"
"  nmap <buffer> v /
"
"  nnoremap <buffer> <silent> a j:call search('\v [^ ]+\/', '')<CR>0zz
"  nnoremap <buffer> <silent> A :call search('\v [^ ]+\/', 'b')<CR>0zz
"
"  nnoremap <buffer> <silent> q :bd<CR>
"
"  "nnoremap <buffer> <silent> <leader>j :call <SID>MoveHalfDown()<CR>
"  "nnoremap <buffer> <silent> <leader>k :call <SID>MoveHalfUp()<CR>
"  nnoremap <buffer> <silent> J :call <SID>MoveHalfDown()<CR>
"  nnoremap <buffer> <silent> K :call <SID>MoveHalfUp()<CR>
"  nnoremap <buffer> <silent> m :call <SID>MoveToModified(1)<CR>
"
"  exe 'nnoremap <buffer> F :! fe ' . a:start . '*<CR>'
"  "nnoremap <buffer> f :call JmShowTreeImage()<CR>
endfunction " JmFuzzer

command! -nargs=* FF :silent call JmFuzzer(<q-args>)
nnoremap f :silent call JmFuzzer()<CR>

