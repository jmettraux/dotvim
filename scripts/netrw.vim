
"
" scripts/netrw.vim


" netrw
"
" with lots of help from
" http://stackoverflow.com/questions/5006950/setting-netrw-like-nerdtree

" absolute width of netrw window
"let g:netrw_winsize = -28

" do not display info on the top of window
let g:netrw_banner = 0

" tree-view
let g:netrw_liststyle = 3

" sort is affecting only: directories on the top, files below
let g:netrw_sort_sequence = '[\/]$,*'

" use the previous window to open file
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1


function! NetrwOpenDirs(dirs)
  if w:_netrw_dir_opened
    return
  endif
  let w:_netrw_dir_opened = 1
  for dir in a:dirs
    call feedkeys('1G:silent! /^| ' . dir . '\/o')
  endfor
  call feedkeys(':nohlsearch')
  call feedkeys('5G')
endfunction

"nnoremap <silent> ff :Explore .<CR>:call NetrwOpenDirs([ 'lib', 'src', 'spec' ])<CR>

function! <SID>NetrwRemap()
  "nmap <silent><buffer> ff :buffer #<CR>
  nmap <silent><buffer> ff :call <SID>JmBufAlt()<CR>
  nmap <buffer> o <CR>
  nmap <buffer> <space> <CR>
  nmap <buffer> <leader>; <CR>
endfunction
au FileType netrw call <SID>NetrwRemap()

