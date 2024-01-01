
"
" scripts/autocmd.vim


au BufRead *.erb set filetype=eruby
au BufRead *.rake set filetype=ruby
au BufRead *.rconf set filetype=ruby
au BufNewFile,BufRead *.go set filetype=go
au BufNewFile,BufRead *.ru set filetype=ruby
au BufNewFile,BufRead *.applescript set filetype=applescript

au BufNewFile,BufRead *.slim set filetype=slim
"au BufNewFile,BufRead *.slim highlight ColorColumn ctermbg=16
"  " disable > 80 column highlight

au BufNewFile,BufRead *.flo set ft=flor
au BufNewFile,BufRead *.flor set ft=flor
au BufNewFile,BufRead *.flon set ft=flor
au BufNewFile,BufRead *.fln set ft=flor

au BufNewFile,BufRead *.hp41 set ft=hp41
au BufNewFile,BufRead *.hp42 set ft=hp42

au BufNewFile,BufRead *.json set ft=javascript

au BufNewFile,BufRead *.ino set ft=cpp
au BufNewFile,BufRead *.scad set ft=openscad
au BufNewFile,BufRead *.fish set ft=fish
au BufNewFile,BufRead *.log set ft=jolog

au BufNewFile,BufRead *.liquid set ft=liquid
au BufNewFile,BufRead */_layouts/*.html set ft=liquid

au BufNewFile,BufRead *.html,*.xml,*.textile
  \ if getline(1) == '---' | set ft=liquid | endif

au FileType java set shiftwidth=4
"au FileType java set autoindent
au FileType java set noexpandtab
au FileType java set tabstop=4
au FileType java set shiftwidth=4

au BufNewFile,BufRead Gemfile setlocal ft=ruby
au FileType ruby set shiftwidth=2

au FileType go set tabstop=2

au BufRead COMMIT_EDITMSG call feedkeys('1G')
  " go to first line of commit messages

