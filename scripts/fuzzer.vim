
function! JmFuzzer()

  let tmp_path = '/tmp/fuzzer.txt'

  execute "! ruby30 ~/.vim/scripts/fuzzer.rb " . tmp_path
  execute ":redraw!"

  let lines = readfile(tmp_path)

  if len(lines) > 0
    execute ":e " . lines[0]
  endif
endfunction " JmFuzzer

nnoremap f :silent call JmFuzzer()<CR>

