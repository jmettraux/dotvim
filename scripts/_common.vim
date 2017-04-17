
"
" _common.vim
"
" functions common to all the scripts/*.vim
"
" Nota bene: the :scriptnames command list all the scripts loaded by Vim,
" by load order

function! JmNtr(s)

  return substitute(a:s, '[^a-zA-Z0-9]', '_', 'g')
endfunction

