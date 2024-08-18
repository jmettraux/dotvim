
"
" scripts/codespell.vim

function! s:CodeSpell()

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let bn = bufnr('==CodeSpell')
  "let bn = JmBufferNumber('==ListFiles')

  if bn > -1 | exe '' . bn . 'bwipeout!' | endif
    " close previous buffers if any

  exe 'new | only'
    " | only makes it full window
  silent file ==CodeSpell
    " replace buffer name
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal nobuflisted
  setlocal filetype=CodeSpell

  setlocal noautoindent
  setlocal nocindent
  setlocal nosmartindent
  setlocal indentexpr=

  let cs = '/usr/local/bin/codespell'

  if filereadable('.codespell-ignore')
    exe 'silent r ! ' . cs . ' -I .codespell-ignore'
  else
    exe 'silent r ! ' . cs
  endif

  execute '%s/\v^\.\///'
  execute '%s/\v(\d): /\1  /'
  "execute '%s/ ==> / →  /'
  execute '%s/ ==> / ⟶   /'

  call append(0, [ '', '== codespell' ])
  call append(line('$'), [ '' ])

  call feedkeys('1G04G')

  setlocal syntax=codespell
  setlocal nomodifiable
  setlocal cursorline

  nnoremap <buffer> o gF
  nnoremap <buffer> <space> gF
  nnoremap <buffer> <CR> gF
    "
    " gf goes to the file
    " gF goes to the file and line
    "
  "nnoremap <buffer> o :call JmOpenTreeFile()<CR>
  "nnoremap <buffer> <space> :call JmOpenTreeFile()<CR>
  "nnoremap <buffer> <CR> :call JmOpenTreeFile()<CR>
    "
    " overkill

  nnoremap <buffer> r :call <SID>CodeSpell()<CR>

  nmap <buffer> s /
    " poor man's search

endfunction " CodeSpell


command! -nargs=0 CodeSpell :call <SID>CodeSpell()
"nnoremap <silent> <leader>j :call <SID>Jumps()<CR>

