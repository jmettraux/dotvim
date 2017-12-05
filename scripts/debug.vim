
" inject a ruby tap
"
command! Tap :normal o<ESC>0C.tap { |x| p x }<ESC>013l

" inject console.log([ 0, 1 ]);
"
command! Clo :normal o<ESC>0Cconsole.log([ 0, 1 ]);<ESC>014l

" inject a js throw
"
command! Thro :normal o<ESC>0Cif (true) throw new Error("Thro:" + JSON.stringify(xxx));<ESC>051l


