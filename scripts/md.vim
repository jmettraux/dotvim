
au BufReadPost,BufNewFile *.md call EnableMarkdownNavigation()
function EnableMarkdownNavigation()
  nmap bb :call search('\v\[[^\]]+\]\([^)]+\)')<CR>
  nmap aa :call search('\v\[[^\]]+\]\([^)]+\)', 'b')<CR>
  nmap gg :call search('\v\([^)]+\)')<CR>lgf
endfunction

