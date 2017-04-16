
function! s:OpenGitDiff()

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  if bufnr('==GitDiff') > 0 | exe 'bwipeout! ==GitDiff' | endif
    " close previous GitDiff if any

  exe 'new | only'
    " | only makes it full window
  exe 'file ==GitDiff'
    " replace buffer name
  exe 'setlocal buftype=nofile'
  exe 'setlocal bufhidden=hide'
  exe 'setlocal noswapfile'
  exe 'setlocal nobuflisted'
  "exe 'setlocal filetype=ListFiles'

  exe 'silent r! git diff | perl ~/.vim/scripts/rediff.pl'

  setlocal syntax=gitdiff

  nmap <buffer> a :call search('^.\+ ---+++', '')<CR>:echo<CR>0
  nmap <buffer> A :call search('^.\+ ---+++', 'b')<CR>:echo<CR>0
    " silently go to next file

  exe 'normal 1Gdda'

  nmap <buffer> o gF
  nmap <buffer> <SPACE> gF
  nmap <buffer> <CR> gF
endfunction "OpenGitDiff
nnoremap <silent> <leader>d :call <SID>OpenGitDiff()<CR>

