
" bundle.vim - MIT licensed

function! s:BundleList()

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  if bufnr('==BundleList') > 0 | exe 'bwipeout! ==BundleList' | endif
    " close previous BundleList if any

  exe 'new | only'
    " | only makes it full window
  exe 'silent file ==BundleList'
    " replace buffer name
  exe 'setlocal buftype=nofile'
  exe 'setlocal bufhidden=hide'
  exe 'setlocal noswapfile'
  exe 'setlocal nobuflisted'
  "exe 'setlocal filetype=ListFiles'

  exe 'silent r! perl ~/.vim/scripts/bundle_list.pl'

  setlocal syntax=bundlelist

  exe 'normal 1G'

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

