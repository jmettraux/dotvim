
function! JmFuzzer(key='')

  "let tmp_path = '/tmp/fuzzer__' . JmNtr(getcwd()) . '.txt'
  let tmp_path = '.vimfuzz'

  execute "! ruby30 ~/.vim/scripts/fuzzer.rb " . tmp_path . " " . a:key
  execute ":redraw!"

  let lines = readfile(tmp_path)

  if len(lines) > 0
    if lines[0] == ''
      " do nothing
    elseif lines[0] == '(log)'
      Gil
    elseif lines[0] == '(buffers)'
      ListFiles
    elseif lines[0] == '(diff)'
      Delta
    elseif lines[0] =~ '/$'
      execute ":Vt " . lines[0]
    else
      execute ":e " . lines[0]
    endif
  endif
endfunction " JmFuzzer

command! -nargs=* FF :call JmFuzzer(<q-args>)
nnoremap f :silent call JmFuzzer()<CR>

