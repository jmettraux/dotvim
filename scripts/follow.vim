
" https://stackoverflow.com/questions/867721/tail-like-functionality-for-gvim/48316467
"
command! -nargs=0 Follow :set autoread | au CursorHold * checktime | call feedkeys("G")

