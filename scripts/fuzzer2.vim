
"
" fuzzer2.vim


function! JmFuzzerAddChar(c)
  call writefile([ (getline(1) . a:c) ], '.vimfuzz2', 'a')
  call JmFuzzer()
endfunction " JmFuzzerAddChar

function! JmFuzzerClear()
  call writefile([ '' ], '.vimfuzz2', 'a')
  call JmFuzzer()
endfunction " JmFuzzerClear

function! JmFuzzerBackspace()
  let s = getline(1)
  let s1 = strpart(s, 0, strlen(s) - 1)
  call writefile([ s1 ], '.vimfuzz2', 'a')
  call JmFuzzer()
endfunction " JmFuzzerBackspace


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
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal cursorline

  exe '%d'
  "normal O
  exe 'silent r! /usr/bin/env python ~/.vim/scripts/fuzzer.py'
  normal 1Gdd2G0
  setlocal syntax=fuzzer
  setlocal nomodifiable

  nnoremap <buffer> a :call JmFuzzerAddChar('a')<CR>
  nnoremap <buffer> b :call JmFuzzerAddChar('b')<CR>
  nnoremap <buffer> c :call JmFuzzerAddChar('c')<CR>
  nnoremap <buffer> d :call JmFuzzerAddChar('d')<CR>
  nnoremap <buffer> e :call JmFuzzerAddChar('e')<CR>
  nnoremap <buffer> f :call JmFuzzerAddChar('f')<CR>
  nnoremap <buffer> g :call JmFuzzerAddChar('g')<CR>
  nnoremap <buffer> H :call JmFuzzerAddChar('h')<CR>
  nnoremap <buffer> i :call JmFuzzerAddChar('i')<CR>
  nnoremap <buffer> J :call JmFuzzerAddChar('j')<CR>
  nnoremap <buffer> K :call JmFuzzerAddChar('k')<CR>
  nnoremap <buffer> L :call JmFuzzerAddChar('l')<CR>
  nnoremap <buffer> m :call JmFuzzerAddChar('m')<CR>
  nnoremap <buffer> n :call JmFuzzerAddChar('n')<CR>
  nnoremap <buffer> o :call JmFuzzerAddChar('o')<CR>
  nnoremap <buffer> p :call JmFuzzerAddChar('p')<CR>
  nnoremap <buffer> q :call JmFuzzerAddChar('q')<CR>
  nnoremap <buffer> r :call JmFuzzerAddChar('r')<CR>
  nnoremap <buffer> s :call JmFuzzerAddChar('s')<CR>
  nnoremap <buffer> t :call JmFuzzerAddChar('t')<CR>
  nnoremap <buffer> u :call JmFuzzerAddChar('u')<CR>
  nnoremap <buffer> v :call JmFuzzerAddChar('v')<CR>
  nnoremap <buffer> w :call JmFuzzerAddChar('w')<CR>
  nnoremap <buffer> x :call JmFuzzerAddChar('x')<CR>
  nnoremap <buffer> y :call JmFuzzerAddChar('y')<CR>
  nnoremap <buffer> z :call JmFuzzerAddChar('z')<CR>

  nnoremap <buffer> - :call JmFuzzerAddChar('-')<CR>
  nnoremap <buffer> _ :call JmFuzzerAddChar('_')<CR>
  nnoremap <buffer> . :call JmFuzzerAddChar('.')<CR>

  nnoremap <buffer> 0 :call JmFuzzerAddChar('0')<CR>
  nnoremap <buffer> 1 :call JmFuzzerAddChar('1')<CR>
  nnoremap <buffer> 2 :call JmFuzzerAddChar('2')<CR>
  nnoremap <buffer> 3 :call JmFuzzerAddChar('3')<CR>
  nnoremap <buffer> 4 :call JmFuzzerAddChar('4')<CR>
  nnoremap <buffer> 5 :call JmFuzzerAddChar('5')<CR>
  nnoremap <buffer> 6 :call JmFuzzerAddChar('6')<CR>
  nnoremap <buffer> 7 :call JmFuzzerAddChar('7')<CR>
  nnoremap <buffer> 8 :call JmFuzzerAddChar('8')<CR>
  nnoremap <buffer> 9 :call JmFuzzerAddChar('9')<CR>

  nnoremap <buffer> <backspace> :call JmFuzzerBackspace()<CR>
  nnoremap <buffer> <delete> :call JmFuzzerBackspace()<CR>
  nnoremap <buffer> C :call JmFuzzerClear()<CR>

  nnoremap <buffer> <CR> :call JmOpenTreeFile()<CR>

"  nnoremap <buffer> o :call JmOpenTreeFile()<CR>
"  nnoremap <buffer> e :call JmOpenTreeFile('edit')<CR>
"  nnoremap <buffer> <space> :call JmOpenTreeFile()<CR>
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
endfunction " JmFuzzer

command! -nargs=* FF :silent call JmFuzzer()
nnoremap f :silent call JmFuzzer()<CR>

