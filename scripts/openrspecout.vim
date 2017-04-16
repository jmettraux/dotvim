
function! s:OpenRspecOut()

  exe 'e .rspec.out'

  exe 'setlocal buftype=nofile'
  exe 'setlocal bufhidden=hide'
  exe 'setlocal noswapfile'
  exe 'setlocal nobuflisted'
  "exe 'setlocal ro'
  exe 'setlocal filetype=.rspec.out'

  exe 'silent! %s/\%x1B\[\d\+\(;\d\+\)\?m//g'
  exe 'silent %s/\v\s*$//'
    " 'silent' to silence the output
    " 'silent!' to also silence errors

  exe 'normal G'

  setlocal syntax=rspecout

  nmap <buffer> o gF
  nmap <buffer> <space> gF
  nmap <buffer> <CR> gF

  nmap <buffer> a :call search('# \.\/', '')<CR>:echo<CR>ll
  nmap <buffer> A 0:call search('# \.\/', 'b')<CR>:echo<CR>ll
    " silently go to next local filename

  "nmap <buffer> n :silent /\.\//<CR>w:nohlsearch<CR>
  nmap <buffer> b :call search('\.\/', 'b')<CR>
  nmap <buffer> n :call search('\.\/', '')<CR>
    " no hl involved :-)
endfunction " OpenRspecOut

nnoremap <silent> <leader>r :call <SID>OpenRspecOut()<CR>

