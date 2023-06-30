
function! JmFuzzer()

  "let f = system("/usr/bin/env ruby30 ~/.vim/scripts/fuzzer.rb")
  "echo "f: " . f

  execute "! ruby30 ~/.vim/scripts/fuzzer.rb /tmp/fuzzer.txt"
  execute ":redraw!"

  "let job = job_start('ruby30 ~/.vim/scripts/fuzzer.rb')
endfunction " JmFuzzer

nnoremap f :silent call JmFuzzer()<CR>

