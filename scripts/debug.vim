
" inject a ruby tap
"
command! Tap :normal o<ESC>0C.tap { |x| pp x }<ESC>013l

" inject console.log([ 0, 1 ]);
"
command! Clo :normal o<ESC>0Cconsole.log([ 0, 1 ]);<ESC>014l

" inject a js throw
"
command! Thro :normal o<ESC>0Cif (true) throw new Error("Thro:" + JSON.stringify(xxx));<ESC>051l

command! Rescue :normal o<ESC>0Cbeginrescue => err  p [ __FILE__, __LINE__ ]p errputs err.backtraceend<ESC><<0

command! Tim :normal O<ESC>0Ct0 = Time.now<ESC>jo<ESC>0Cp [ :took, Time.now - t0 ]<ESC>k0
command! Tom :normal O<ESC>0Cdef _monow; Process.clock_gettime(Process::CLOCK_MONOTONIC); end; t0 = _monow<ESC>jo<ESC>0Cp [ :took, _monow - t0 ]<ESC>k0

