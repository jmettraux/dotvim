
function! JmDictLookup(word)

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let fn = '_d___' . JmNtr(a:word)

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
  exe 'silent r! dict "' . a:word . '"'
  exe 'silent %s/\v[ 	]+$//e'
    " e to silent when no pattern match
  normal 1G
  setlocal syntax=dictionary
  setlocal nomodifiable

  nnoremap <buffer> <silent> q :bd<CR>
endfunction " JmDictLookup

command! -nargs=+ Dict :call JmDictLookup(<q-args>)

"nnoremap <leader>^ :call JmDictLookup(expand('<cword>'))
nnoremap ^^ :call JmDictLookup(expand('<cword>'))

