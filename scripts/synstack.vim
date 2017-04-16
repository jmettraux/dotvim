
" Show syntax highlighting groups for word under cursor
"
" from http://vimcasts.org/episodes/creating-colorschemes-for-vim/
"
function! <SID>SynStack()

  if !exists("*synstack") | return | endif

  for x in map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    redi => out
    silent exe "hi" x
    redi END
    exe "hi" x
    let link = matchstr(out, ' links to \zs.*\ze$')
    if !empty(link)
      exe "hi" link
    endif
  endfor

  echo '.'
endfunc
nnoremap <silent> <leader>s :call <SID>SynStack()<CR>

