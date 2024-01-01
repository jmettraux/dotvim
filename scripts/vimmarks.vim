
"
" scripts/vimmarks.vim


function! <SID>JmWriteToVimmarks()
  let li = line('.')
  let pa = expand('%') . ':' . li
  let tx = JmStrip(getline(li))
  let tx = JmStrip(strpart(tx, 0, 80 - len(pa) - 4))
  call writefile([ pa . "  # " . tx ], '.vimmarks', 'a')
  echo "added \"" . pa . "\" to .vimmarks"
endfunction

nnoremap <leader>x :call <SID>JmWriteToVimmarks()<CR>
nnoremap <leader>X :e .vimmarks<CR>

