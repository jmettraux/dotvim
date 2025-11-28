
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

let g:_python = '/usr/bin/env python '
if isdirectory($HOME . '/.vim_python/bin')
  let g:_python = $HOME . '/.vim_python/bin/python '
endif

let g:_ruby = glob($HOME . '/.rubies/ruby-3.*', 0, 1)[-1] . '/bin/ruby'

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

set mouse=a
  " at least prevents scrolling in the "term" on xterm

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

"filetype plugin indent on
filetype on

" temp
"
"nnoremap q :%s/    /  /g<ENTER>
"nnoremap t :%s/ *$//<ENTER>
"command! -nargs=0 Mkd :silent :set filetype=mkd

command! -nargs=0 Clean :silent %s/\v\s*$// | nohlsearch
command! -nargs=0 Unblank :g/^$/d

" colors
"
colorscheme jm_green
"colorscheme jm_blue
"set termguicolors

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
"nnoremap <leader>j <C-w>j
"nnoremap <leader>k <C-w>k
"
" split
"nnoremap \ :split<CR>
"nnoremap @ <C-w>+
"nnoremap - <C-w>-

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
nnoremap <leader>o :only!<CR>

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

"nnoremap <silent> <leader>u :setlocal number!<CR>

"nnoremap <silent> <leader>m ma
nnoremap <silent> <leader>a g'a
"nnoremap <silent> <leader>y y'a
"nnoremap <silent> <leader>d d'a

"inoremap <C-j> <ESC>


" pgup / pgdown
"
"nnoremap <silent> <space> <C-d>
"nnoremap <silent> , <C-u>
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>

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


"nnoremap <silent> <leader>tt :w<CR>:e ~/scratch.txt<CR>

" from http://howivim.com/2016/salvatore-sanfilippo/
"
"if has("autocmd")
autocmd BufReadPost * if line("'\"") | silent! exe "'\"" | endif
  " open file and go to last cursor position
"endif


" Some Meta
"
"nnoremap <leader>ev :e $MYVIMRC<CR>
"nnoremap <leader>sv :source $MYVIMRC<CR>
"nnoremap <leader>ec :e ~/.vim/colors/jm_green.vim<CR>
"nnoremap <leader>sc :colorscheme jm_green<CR>
"nnoremap <leader>gd :! cd ~/.vim && git diff<CR>



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
"nnoremap <leader><TAB> i<C-v><TAB><ESC>


" https://github.com/mcantor/no_plugins/blob/master/no_plugins.vim
"
set path+=**
set wildmenu
set wildignore=*.swp

"set makeprg=bundle\ exec\ rspec\ -f\ QuickfixFormatter


"nnoremap <leader><BS> 0D
"nnoremap <leader>0 0D
  " d0 delete from here to col 0...


"nnoremap <leader>ts :r ! ruby -e "puts '###' + Time.now.strftime('\%Y-\%m-\%d \%H:\%M:\%S')"<CR>


let g:markdown_fenced_languages = [ 'html', 'js=javascript', 'ruby', 'python', 'c', 'java', 'yaml', 'json' ]

"nnoremap <C-l> 0 39l
nnoremap <C-l> :silent execute "normal! 0 " . (col("$") / 2) . "l"<CR>:echo<CR>
  " got to the middle of the current line
  " the :echo clears the 'command line'


" enable :Man ls
"
runtime ftplugin/man.vim
  "
  " use :only to make the help window fullscreen...

"
" Trees

"command! -nargs=0 Tlib :Vt lib/
"command! -nargs=0 Tsrc :Vt src/
"command! -nargs=0 Tpos :Vt posts/

"
" French and Russian

command! -nargs=0 Kru :set keymap=russian-yawerty-jp
command! -nargs=0 Kno :set keymap=
"command! -nargs=0 Sof :source ~/.vim/fraccents.vim
command! -nargs=0 French :source ~/.vim/fraccents.vim

