
function! s:GoToLink()
  let cursor = getpos('.')
  call setpos('.', [ 0, 0, 0, 0 ])
  let r = search(' link: ', 'c')
  if r == 0
    call setpos('.', cursor)
    return
  end
  normal www
  let path = expand('<cfile>')
  call setpos('.', cursor)
  execute 'edit ' . path
endfunction " GoToLink

nnoremap <leader>w :call <SID>GoToLink()<CR>

