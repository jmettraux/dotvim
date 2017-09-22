
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
endfunction " BundleList

command! -nargs=0 Blist :call <SID>BundleList()

