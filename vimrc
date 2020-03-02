
"
" my .vimrc, sorry, nothing fancy here

" detect system
"
let g:isWindows = has('win32')
let g:isUnix = has('unix')
let g:uname = g:isWindows ? 'Windows' : system('uname')[:-2]
let g:isDarwin = g:uname == 'Darwin'
let g:isOpenBSD = g:uname == 'OpenBSD'
let g:isOpenBsd = g:isOpenBSD


set nocompatible

set modeline
set modelines=2

set shiftwidth=2
set expandtab
set tabstop=4
set softtabstop=4
set showmatch
set vb
"set nu
set showcmd
"set colorcolumn=80 " vim 7.3

set redrawtime=10000 " for vim 8.1.1438 on OpenBSD

let mapleader=';'

syntax on

set ruler

" mostly for linux or cygwin
"
set backspace=indent,eol,start

set encoding=utf-8
set enc=utf-8
set fenc=utf-8

"set smartindent
set autoindent
set smarttab

set history=128
set undolevels=1024

set cmdwinheight=20
  " q: q/ q?

" disabling the pulldown autocomplete thinggy
inoremap <C-n> <nop>

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
au BufNewFile,BufRead *.json set ft=javascript

au BufNewFile,BufRead *.ino set ft=cpp
au BufNewFile,BufRead *.scad set ft=openscad
au BufNewFile,BufRead *.fish set ft=fish
au BufNewFile,BufRead *.log set ft=jolog

function! <SID>GoMkd()
  set filetype=mkd
  syntax sync fromstart
endfunction
au BufNewFile,BufRead *.md :call <SID>GoMkd()

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

"filetype plugin indent on
filetype on

" temp
"
"nnoremap q :%s/    /  /g<ENTER>
"nnoremap t :%s/ *$//<ENTER>
command! -nargs=0 Clean :silent %s/\v\s*$// | nohlsearch
"command! -nargs=0 Mkd :silent :set filetype=mkd

" colors
"
colorscheme jm_green
"colorscheme jm_blue

" trailing white space highlight
"
"let ruby_space_errors=1
"let ruby_fold=1
"
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/
  " from http://blog.kamil.dworakowski.name/2009/09/unobtrusive-highlighting-of-trailing.html


" http://vim.wikia.com/wiki/Fix_syntax_highlighting
"
"nnoremap <leader>@ :syntax sync fromstart<CR>
  " wrapped in _ from now on


" windows
"
" horizontal
"nnoremap <leader>h <C-w>h
"nnoremap <leader>l <C-w>l
"
" vertical
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
"
" split
"nnoremap \ :split<CR>
nnoremap @ <C-w>+
nnoremap - <C-w>-

"" :q and :w
"" there is also ZZ for :q
nnoremap <leader>q :q<CR>
"nnoremap <leader>w :w<CR>

"nnoremap <leader>g <C-o>
"nnoremap <leader>gg <C-o>

let g:jmAlt = 1
function! <SID>JmBufLeave()
  if &filetype !=# 'netrw' && &filetype !=# 'ListFiles'
    let g:jmAlt = bufnr('%')
  endif
endfunction
function! <SID>JmBufAlt()
  exe "buffer " . g:jmAlt
endfunction
"
au BufLeave * :call <SID>JmBufLeave()
"
nnoremap <silent> <leader>; :call <SID>JmBufAlt()<CR>

"nnoremap <silent> <leader>n :n<CR>
"nnoremap <silent> <leader>c :only!<CR>

"nnoremap <silent> <leader>b :buffers<CR>
"nnoremap <silent> <leader>1 :e #1<CR>
"nnoremap <silent> <leader>2 :e #2<CR>
"...
"nnoremap <silent> <leader>a 0w

nnoremap <leader>f gF
  " go file
nnoremap <leader>H :let @" = expand("%") . ':' . line('.')<CR>
  " 'here'

"nnoremap <leader>k 0wDa
"nnoremap <C-k> 0wDa
"inoremap <C-k> <ESC>0wDa
  " <C-k> is for digraphs
nnoremap <C-h> bDa
inoremap <C-h> <ESC>bDa

"cnoremap <C-w> "zyiw<C-r>"
cnoremap <C-w> <C-R>=expand('<cword>')<CR>
"cnoremap <C-W> <C-R>=expand('<cWORD>')<CR>

"nnoremap <silent> <leader>t /TODO<CR>
" TODO: pop that search when done

nnoremap <silent> <leader>u :setlocal number!<CR>

"nnoremap <silent> <leader>m ma
nnoremap <silent> <leader>a g'a
"nnoremap <silent> <leader>y y'a
"nnoremap <silent> <leader>d d'a

inoremap <C-j> <ESC>

function! <SID>JmWriteToVimmarks()
  let li = line('.')
  let pa = expand('%') . ':' . li
  let tx = JmStrip(getline(li))
  let tx = JmStrip(strpart(tx, 0, 80 - len(pa) - 4))
  call writefile([ pa . "  # " . tx ], '.vimmarks', 'a')
  echo "added \"" . pa . "\" to .vimmarks"
endfunction
nnoremap <leader>x :call <SID>JmWriteToVimmarks()<CR>
nnoremap <leader>X :e .vimmarks<CR>

" netrw
"
" with lots of help from
" http://stackoverflow.com/questions/5006950/setting-netrw-like-nerdtree

" absolute width of netrw window
"let g:netrw_winsize = -28

" do not display info on the top of window
let g:netrw_banner = 0

" tree-view
let g:netrw_liststyle = 3

" sort is affecting only: directories on the top, files below
let g:netrw_sort_sequence = '[\/]$,*'

" use the previous window to open file
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1

nnoremap <silent> ff :Explore .<CR>:call NetrwOpenDirs([ 'lib', 'src', 'spec' ])<CR>

function! <SID>NetrwRemap()
  "nmap <silent><buffer> ff :buffer #<CR>
  nmap <silent><buffer> ff :call <SID>JmBufAlt()<CR>
  nmap <buffer> o <CR>
  nmap <buffer> <space> <CR>
  nmap <buffer> <leader>; <CR>
endfunction
au FileType netrw call <SID>NetrwRemap()


function! NetrwOpenDirs(dirs)
  if w:_netrw_dir_opened
    return
  endif
  let w:_netrw_dir_opened = 1
  for dir in a:dirs
    call feedkeys('1G:silent! /^| ' . dir . '\/o')
  endfor
  call feedkeys(':nohlsearch')
  call feedkeys('5G')
endfunction


" pgup / pgdown
"
"nnoremap <silent> <space> <C-d>
"nnoremap <silent> , <C-u>

" search
"
set incsearch
set hlsearch
nnoremap <silent> _ :nohlsearch<CR>:syntax sync fromstart<CR>
"nnoremap <silent> \ :nohlsearch<CR>

runtime! scripts/*.vim

"function! <SID>Grep(regex)
"  exe 'vimgrep /'.a:regex.'/j ./**/*.rb'
"  copen 20
"endfunction
"command! -nargs=1 G :call <SID>Grep('<args>')


"function! <SID>Test(...)
"  let i = 1
"  while i <= a:0
"    echo "" . i . ": " . a:{i}
"    let i += 1
"  endwhile
"endfunction
"command! -nargs=* Te :call <SID>Test('<args>')


" copying and pasting
"
if has("win32")
  " cygwin
  nnoremap <silent> <C-p> <ESC>:r ! getclip<CR>
  nnoremap <silent> <leader>v <ESC>:r ! getclip<CR>
  command! -nargs=0 C :silent w ! putclip
  vmap <silent> <leader>c <ESC>:'<,'>:w ! putclip<CR><CR>
else
  if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
      nnoremap <silent> <C-p> <ESC>:r ! pbpaste<CR>
      nnoremap <silent> <leader>v <ESC>:r ! pbpaste<CR>
      command! -nargs=0 C :silent w ! pbcopy
      vmap <silent> <leader>c <ESC>:'<,'>:w ! pbcopy<CR><CR>
    else
      nnoremap <silent> <C-p> <ESC>:r ! xclip -o<CR>
      nnoremap <silent> <leader>v <ESC>:r ! xclip -o<CR>
      command! -nargs=0 C :silent w ! xclip -i
      vmap <silent> <leader>c <ESC>:'<,'>:w ! xclip -i<CR><CR>
    endif
  endif
endif

"nnoremap <silent> <leader>tt :w<CR>:e ~/scratch.txt<CR>

" from http://howivim.com/2016/salvatore-sanfilippo/
"
if has("autocmd")
  autocmd BufReadPost * if line("'\"") | exe "'\"" | endif
    " open file and go to last cursor position
endif


" Status bar
"
set laststatus=2
set statusline=
set statusline+=%-3.3n\ " buffer number
set statusline+=%f\ " filename
set statusline+=%h%m%r%w " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
"set statusline+=\ %{fugitive#statusline()} " fugitive
"set statusline+=\ %{rvm#statusline()} " rvm
set statusline+=%= " right align remainder
set statusline+=0x%-8B " character value
set statusline+=\ c%c%V " column
set statusline+=\ %l/%L " line
set statusline+=\ %P " file position

" Some Meta
"
"nnoremap <leader>ev :e $MYVIMRC<CR>
"nnoremap <leader>sv :source $MYVIMRC<CR>
"nnoremap <leader>ec :e ~/.vim/colors/jm_green.vim<CR>
"nnoremap <leader>sc :colorscheme jm_green<CR>
"nnoremap <leader>gd :! cd ~/.vim && git diff<CR>


"" from http://vim.wikia.com/wiki/Simple_Macros_to_quote_and_unquote_a_word
""
"" 'quote' a word
"nnoremap qw :silent! normal mpea'<Esc>bi'<Esc>`pl
"" double "quote" a word
"nnoremap qd :silent! normal mpea"<Esc>bi"<Esc>`pl

" 'quote' a word
nnoremap qw :silent! normal yiwi'<ESC>ea'<ESC>
" double "quote" a word
nnoremap qd :silent! normal yiwi"<ESC>ea"<ESC>
" remove quotes from a word
nnoremap wq :silent! normal mpeld bhd `ph<CR>


" exrc
"
" accept local .vimrc but check for ownership (secure)
"
set exrc
set secure


"
" g CTRL-g to display offsets
"

" inserting a real tab... Makefile...
nnoremap <leader><TAB> i<C-v><TAB><ESC>


" https://github.com/mcantor/no_plugins/blob/master/no_plugins.vim
"
set path+=**
set wildmenu
set wildignore=*.swp

"set makeprg=bundle\ exec\ rspec\ -f\ QuickfixFormatter


let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27

nnoremap <leader>] :highlight ColorColumn ctermbg=16<CR>:echo<CR>
nnoremap <leader>[ :highlight ColorColumn ctermbg=235 guibg=#2c2d27<CR>:echo<CR>


nnoremap <leader>ts :r ! ruby -e "puts '###' + Time.now.strftime('\%Y-\%m-\%d \%H:\%M:\%S')"<CR>

