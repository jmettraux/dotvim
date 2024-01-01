
"
" fuzzer2.vim


function! s:FuzzerAddChar(c)
  call writefile([ (getline(1) . a:c) ], '.vimfuzz2', 'a')
  call JmFuzzer()
endfunction " FuzzerAddChar

function! s:FuzzerClear()
  call writefile([ '' ], '.vimfuzz2', 'a')
  call JmFuzzer()
endfunction " FuzzerClear

function! s:FuzzerChange()
  set modifiable
  normal! 1G0D
  startinsert!
endfunction " FuzzerChange

function! s:FuzzerChangeDone()
  call writefile([ getline(1) ], '.vimfuzz2', 'a')
  call JmFuzzer()
endfunction " FuzzerChangeDone

function! s:FuzzerBackspace()
  let s = getline(1)
  let s1 = strpart(s, 0, strlen(s) - 1)
  call writefile([ s1 ], '.vimfuzz2', 'a')
  call JmFuzzer()
endfunction " FuzzerBackspace

function! s:FuzzerOptionGet(k, default)
  let lines = readfile('.vimfuzz2')
  let lines = filter(lines, 'v:val =~ "^' . a:k . ':"')
  if len(lines) > 0 | return strpart(lines[0], len(a:k) + 1) | endif
  return a:default
endfunction " FuzzerOptionGet

function! s:FuzzerToggleSuffix()
  let s = getline(1)
  let l = <SID>FuzzerOptionGet('suffixes', '.js .rb .slim .css')
  let l = split(l, ' ')
  let i = index(l, s)
  if i < 0
    let s1 = l[0]
  else
    let s1 = get(l, i + 1, l[0])
  endif
  call writefile([ s1 ], '.vimfuzz2', 'a')
  call JmFuzzer()
endfunction " FuzzerToggleSuffix


function! JmFuzzer(...)

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  if a:0 > 0
    call writefile([ a:1 ], '.vimfuzz2', 'a')
  endif

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

  nnoremap <buffer> a :call <SID>FuzzerAddChar('a')<CR>
  nnoremap <buffer> b :call <SID>FuzzerAddChar('b')<CR>
  nnoremap <buffer> c :call <SID>FuzzerAddChar('c')<CR>
  nnoremap <buffer> d :call <SID>FuzzerAddChar('d')<CR>
  nnoremap <buffer> e :call <SID>FuzzerAddChar('e')<CR>
  nnoremap <buffer> f :call <SID>FuzzerAddChar('f')<CR>
  nnoremap <buffer> g :call <SID>FuzzerAddChar('g')<CR>
  nnoremap <buffer> h :call <SID>FuzzerAddChar('h')<CR>
  nnoremap <buffer> i :call <SID>FuzzerAddChar('i')<CR>
  nnoremap <buffer> J :call <SID>FuzzerAddChar('j')<CR>
  nnoremap <buffer> K :call <SID>FuzzerAddChar('k')<CR>
  nnoremap <buffer> l :call <SID>FuzzerAddChar('l')<CR>
  nnoremap <buffer> m :call <SID>FuzzerAddChar('m')<CR>
  nnoremap <buffer> n :call <SID>FuzzerAddChar('n')<CR>
  nnoremap <buffer> o :call <SID>FuzzerAddChar('o')<CR>
  nnoremap <buffer> p :call <SID>FuzzerAddChar('p')<CR>
  nnoremap <buffer> q :call <SID>FuzzerAddChar('q')<CR>
  nnoremap <buffer> r :call <SID>FuzzerAddChar('r')<CR>
  nnoremap <buffer> s :call <SID>FuzzerAddChar('s')<CR>
  nnoremap <buffer> t :call <SID>FuzzerAddChar('t')<CR>
  nnoremap <buffer> u :call <SID>FuzzerAddChar('u')<CR>
  nnoremap <buffer> v :call <SID>FuzzerAddChar('v')<CR>
  nnoremap <buffer> w :call <SID>FuzzerAddChar('w')<CR>
  nnoremap <buffer> x :call <SID>FuzzerAddChar('x')<CR>
  nnoremap <buffer> y :call <SID>FuzzerAddChar('y')<CR>
  nnoremap <buffer> z :call <SID>FuzzerAddChar('z')<CR>

  nnoremap <buffer> H :normal! h<CR>
  nnoremap <buffer> L :normal! l<CR>

  nnoremap <buffer> - :call <SID>FuzzerAddChar('-')<CR>
  nnoremap <buffer> _ :call <SID>FuzzerAddChar('_')<CR>
  nnoremap <buffer> . :call <SID>FuzzerAddChar('.')<CR>

  "nnoremap <buffer> 0 :call <SID>FuzzerAddChar('0')<CR>
  "nnoremap <buffer> 1 :call <SID>FuzzerAddChar('1')<CR>
  "nnoremap <buffer> 2 :call <SID>FuzzerAddChar('2')<CR>
  "nnoremap <buffer> 3 :call <SID>FuzzerAddChar('3')<CR>
  "nnoremap <buffer> 4 :call <SID>FuzzerAddChar('4')<CR>
  "nnoremap <buffer> 5 :call <SID>FuzzerAddChar('5')<CR>
  "nnoremap <buffer> 6 :call <SID>FuzzerAddChar('6')<CR>
  "nnoremap <buffer> 7 :call <SID>FuzzerAddChar('7')<CR>
  "nnoremap <buffer> 8 :call <SID>FuzzerAddChar('8')<CR>
  "nnoremap <buffer> 9 :call <SID>FuzzerAddChar('9')<CR>

  nnoremap <buffer> <backspace> :call <SID>FuzzerBackspace()<CR>
  nnoremap <buffer> <delete> :call <SID>FuzzerBackspace()<CR>

  nnoremap <buffer> D :call <SID>FuzzerClear()<CR>
  nnoremap <buffer> C :call <SID>FuzzerChange()<CR>

  nnoremap <buffer> <CR> :call JmOpenTreeFile()<CR>
  nnoremap <buffer> <space> :call JmOpenTreeFile()<CR>
  nnoremap <buffer> T :call JmShowTree(getline(line('.')))<CR>

  nnoremap <buffer> <silent> <leader>f :call <SID>FuzzerToggleSuffix()<CR>

  inoremap <buffer> <CR> 
  autocmd InsertLeave <buffer> :call <SID>FuzzerChangeDone()

  nnoremap <buffer> @ :call JmZapicat(getline(1))<CR>
endfunction " JmFuzzer

command! -nargs=1 Vf :call JmFuzzer(<q-args>)
"command! -nargs=* FF :silent call JmFuzzer()
nnoremap @ :silent call JmFuzzer()<CR>

