
au BufReadPost,BufNewFile *.scad
  \ command! Trans :normal otranslate([ 0, 0, 0 ])<ESC>bbbbbb
au BufReadPost,BufNewFile *.scad
  \ command! Rota :normal orotate([ 0, 0, 0 ])<ESC>bbbbbb

