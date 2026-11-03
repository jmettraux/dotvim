
"
" cuts.vim

function! s:GitAddFile()

  let path = JmDetermineTreePath()
  if empty(path) | return 0 | endif

  call system('git add ' . path)

  execute ":e"

  echo 'Added ' . path . ' to Git'

endfunction " GitAddFile


function! s:GoToNextModified()

  call search('\v \+([1-9]\d*-\d+|\d+-[1-9]\d*)$', 'we')

endfunction " GoToNextModified

function! s:GoToNextSection()

  call search('\v^### .', 'we')

endfunction " GoToNextSection


function! s:EnterCutsFile()

  set filetype=Cuts

  let @z = system(g:_python . " ~/.vim/scripts/cuts.py", expand('%:p'))
  execute "%delete_"
  silent $put z
  execute "1delete_"
  silent update

  "if line('.') == 1 | call cursor(4, 1) | endif

  setlocal cursorline
  augroup CursorLine
      autocmd!
      autocmd InsertEnter <buffer> setlocal nocursorline
      autocmd InsertLeave <buffer> setlocal cursorline
  augroup END

  setlocal syntax=cuts

  "nnoremap <buffer> o :call JmOpenTreeFile()<CR>
  nnoremap <buffer> <space> :call JmOpenTreeFile()<CR>
  nnoremap <buffer> <enter> :call JmOpenTreeFile()<CR>
  nnoremap <buffer> ga :call <SID>GitAddFile()<CR>
  nnoremap <buffer> zz :call <SID>GoToNextModified()<CR>
  nnoremap <buffer> qq :call <SID>GoToNextSection()<CR>

endfunction " EnterCutsFile

au BufRead,BufNewFile *.cuts call <SID>EnterCutsFile()


function! s:GotoCutsBuffer()

  let l:buffer = bufnr('*.cuts')
  if l:buffer != -1
    execute "buffer " . l:buffer
    return
  endif

  let l:path = glob('*.cuts')
  if l:path != ''
    execute "edit " . l:path
    return
  endif

  echohl ErrorMsg
  echo "No buffer or file found with .cuts extension"
  echohl None

endfunction " GotoCutsBuffer

nnoremap <silent> <leader>z :call <SID>GotoCutsBuffer()<CR>


  " ;-)
  "
au BufRead .vimshorts setlocal syntax=cuts
au BufRead .vimshorts setlocal cursorline

