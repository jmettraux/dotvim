
" inject a ruby tap
"
command! Tap :normal o<ESC>0C.tap { |x| p x }<ESC>013l

" inject console.log([ 0, 1 ]);
"
command! Clo :normal o<ESC>0Cconsole.log([ 0, 1 ]);<ESC>014l

