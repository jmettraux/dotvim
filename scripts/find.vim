
" inspiration: http://vim.wikia.com/wiki/Find_files_in_subdirectories
"
function! <SID>Find(fragment)
  let l:result = system("find . -name '*".a:fragment."*' 2> /dev/null | head -1")
  exe 'e ' l:result
endfunction " Find

command! -nargs=1 F :call <SID>Find('<args>')
command! -nargs=1 Vf :call <SID>Find('<args>')

