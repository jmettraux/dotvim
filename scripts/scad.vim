
au BufReadPost,BufNewFile *.scad
  \ command! Trans :normal otranslate([ 0, 0, 0 ])<ESC>bbbbbb
au BufReadPost,BufNewFile *.scad
  \ command! Rota :normal orotate([ 0, 0, 0 ])<ESC>bbbbbb

au BufReadPost,BufNewFile *.scad
  \ command! Trota :normal otranslate([ 0, 0, 0 ]) rotate([ 0, 0, 0 ])<ESC>

au BufReadPost,BufNewFile *.scad
  \ command! Cube :normal ocube(size=[ 0, 0, 0 ], center=true);<ESC>bbbbbbbbbb

