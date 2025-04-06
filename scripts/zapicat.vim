
"
" scripts/zapicat.vim


function! s:ZapiAddChar(c)
  let a = getline(1) . a:c
  call JmZapicat(a)
endfunction " ZapiAddChar

function! s:ZapiClear()
  call JmZapicat('')
endfunction " ZapiClear

function! s:ZapiChange()
  set modifiable
  normal! 1G0D
  startinsert!
endfunction " ZapiChange

function! s:ZapiChangeDone()
  "call writefile([ getline(1) ], '.vimfuzz2', 'a')
  "call JmFuzzer()
  call JmZapicat(getline(1))
endfunction " ZapiChangeDone

function! s:ZapiBackspace()
  let a = getline(1)
  let a = strpart(a, 0, strlen(a) - 1)
  call JmZapicat(a)
endfunction " ZapiBackspace


function! JmZapicat(...)

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  "let fn = '_F___' . JmNtr(a:start)
  let fn = '_Z___'

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
  0put =join(a:000)

  let as = split(getline(1), ' ')

  let cmd = 'silent r! ' . g:_python . ' ~/.vim/scripts/zapicat-browse.py'
  let cmd = cmd . ' ' . winwidth(0)
  for aa in as
    let cmd = cmd . ' ' . shellescape(aa, 1)
  endfor

  exe cmd

  normal 1Gj

  setlocal syntax=zapicat
  setlocal nomodifiable

  nnoremap <buffer> a :call <SID>ZapiAddChar('a')<CR>
  nnoremap <buffer> b :call <SID>ZapiAddChar('b')<CR>
  nnoremap <buffer> c :call <SID>ZapiAddChar('c')<CR>
  nnoremap <buffer> d :call <SID>ZapiAddChar('d')<CR>
  nnoremap <buffer> e :call <SID>ZapiAddChar('e')<CR>
  nnoremap <buffer> f :call <SID>ZapiAddChar('f')<CR>
  nnoremap <buffer> g :call <SID>ZapiAddChar('g')<CR>
  nnoremap <buffer> h :call <SID>ZapiAddChar('h')<CR>
  nnoremap <buffer> i :call <SID>ZapiAddChar('i')<CR>
  nnoremap <buffer> J :call <SID>ZapiAddChar('j')<CR>
  nnoremap <buffer> K :call <SID>ZapiAddChar('k')<CR>
  nnoremap <buffer> l :call <SID>ZapiAddChar('l')<CR>
  nnoremap <buffer> m :call <SID>ZapiAddChar('m')<CR>
  nnoremap <buffer> n :call <SID>ZapiAddChar('n')<CR>
  nnoremap <buffer> o :call <SID>ZapiAddChar('o')<CR>
  nnoremap <buffer> p :call <SID>ZapiAddChar('p')<CR>
  nnoremap <buffer> q :call <SID>ZapiAddChar('q')<CR>
  nnoremap <buffer> r :call <SID>ZapiAddChar('r')<CR>
  nnoremap <buffer> s :call <SID>ZapiAddChar('s')<CR>
  nnoremap <buffer> t :call <SID>ZapiAddChar('t')<CR>
  nnoremap <buffer> u :call <SID>ZapiAddChar('u')<CR>
  nnoremap <buffer> v :call <SID>ZapiAddChar('v')<CR>
  nnoremap <buffer> w :call <SID>ZapiAddChar('w')<CR>
  nnoremap <buffer> x :call <SID>ZapiAddChar('x')<CR>
  nnoremap <buffer> y :call <SID>ZapiAddChar('y')<CR>
  nnoremap <buffer> z :call <SID>ZapiAddChar('z')<CR>
  nnoremap <buffer> <space> :call <SID>ZapiAddChar(' ')<CR>

  nnoremap <buffer> H :normal! h<CR>
  nnoremap <buffer> L :normal! l<CR>

  "nnoremap <buffer> - :call <SID>ZapiAddChar('-')<CR>
  nnoremap <buffer> _ :call <SID>ZapiAddChar('_')<CR>
  nnoremap <buffer> . :call <SID>ZapiAddChar('.')<CR>

  ""nnoremap <buffer> 0 :call <SID>FuzzerAddChar('0')<CR>
  ""nnoremap <buffer> 1 :call <SID>FuzzerAddChar('1')<CR>
  ""nnoremap <buffer> 2 :call <SID>FuzzerAddChar('2')<CR>
  ""nnoremap <buffer> 3 :call <SID>FuzzerAddChar('3')<CR>
  ""nnoremap <buffer> 4 :call <SID>FuzzerAddChar('4')<CR>
  ""nnoremap <buffer> 5 :call <SID>FuzzerAddChar('5')<CR>
  ""nnoremap <buffer> 6 :call <SID>FuzzerAddChar('6')<CR>
  ""nnoremap <buffer> 7 :call <SID>FuzzerAddChar('7')<CR>
  ""nnoremap <buffer> 8 :call <SID>FuzzerAddChar('8')<CR>
  ""nnoremap <buffer> 9 :call <SID>FuzzerAddChar('9')<CR>

  nnoremap <buffer> <backspace> :call <SID>ZapiBackspace()<CR>
  nnoremap <buffer> <delete> :call <SID>ZapiBackspace()<CR>

  nnoremap <buffer> D :call <SID>ZapiClear()<CR>
  nnoremap <buffer> C :call <SID>ZapiChange()<CR>

  nnoremap <buffer> <CR> :call JmOpenTreeFile()<CR>
  "nnoremap <buffer> T :call JmShowTree(getline(line('.')))<CR>

  "nnoremap <buffer> <silent> <leader>f :call <SID>FuzzerToggleSuffix()<CR>

  inoremap <buffer> <CR> 
  autocmd InsertLeave <buffer> :call <SID>ZapiChangeDone()

  nnoremap <buffer> @ :call JmFuzzer(getline(1))<CR>
endfunction " JmFuzzer

command! -nargs=* Vz :call JmZapicat(<f-args>)
"command! -nargs=* FF :silent call JmZapicat()
nnoremap ` :silent call JmZapicat()<CR>


function! s:ZapicatIndex()

  exe 'sil ! time ' . g:_python . ' ~/.vim/scripts/zapicat-index.py --force'
  exe '! ls -lh .zapicat*'
endfunction " ZapicatIndex

command! -nargs=0 ZapIndex :call <SID>ZapicatIndex()
"command! -nargs=0 Zindex :call <SID>ZapicatIndex()

