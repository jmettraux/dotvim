
" bundle.vim - MIT licensed

function! s:BundleList()

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let fn = tempname() . '__.bundlelist'

  exe 'e ' . fn

  silent r! perl ~/.vim/scripts/bundle_list.pl

  setlocal syntax=bundlelist

  normal 2G
  write

  setlocal nomodifiable

  nnoremap <buffer> o :call <SID>BundleOpen()<CR>
  nnoremap <buffer> <CR> :call <SID>BundleOpen()<CR>
  nnoremap <buffer> <SPACE> :call <SID>BundleOpen()<CR>

  nnoremap <buffer> <silent> q :bd<CR>
endfunction " BundleList

function! s:BundleOpen()

  let l = getline('.')
  let m = matchlist(l, '\v^[^ ]+ +\d[^ ]+ +(.+)$')
  if empty(m) == 0
    let pa = m[1]
    echo pa
    exe ':Vt ' . pa
  endif
endfunction " BundleOpen

command! -nargs=0 Blist :call <SID>BundleList()

au BufRead *.bundlelist set filetype=bundlelist

