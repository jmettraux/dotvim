
"
" my .vimrc, sorry, nothing fancy here
"

set nocompatible

set shiftwidth=2
set expandtab
set tabstop=4
set softtabstop=4
set showmatch
set vb
"set nu
syntax on

set ruler

" mostly for linux or cygwin
"
set backspace=indent,eol,start

set encoding=utf-8
set enc=utf-8
set fenc=utf-8

set smartindent
set smarttab

"let ruby_space_errors=1
"let ruby_fold=1
"
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/
  " from http://blog.kamil.dworakowski.name/2009/09/unobtrusive-highlighting-of-trailing.html

autocmd BufRead *.go set filetype=go
autocmd BufRead *.md set filetype=mkd
autocmd BufRead *.rad set filetype=radial
autocmd BufRead *.radial set filetype=radial
autocmd BufRead *.erb set filetype=eruby
autocmd BufRead *.ru set filetype=ruby
autocmd BufRead *.rake set filetype=ruby
autocmd BufRead *.rconf set filetype=ruby

autocmd FileType ruby set shiftwidth=2
"filetype plugin indent on
filetype on

" temp
"
"map q :%s/    /  /g<ENTER>
"map t :%s/ *$//<ENTER>
command! -nargs=0 Clean :silent %s/ *$// | nohlsearch

" colors
"
colorscheme jm_green
"colorscheme jm_blue

" Show syntax highlighting groups for word under cursor
"
" from http://vimcasts.org/episodes/creating-colorschemes-for-vim/
"
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  for x in map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    exe "hi " . x
  endfor
endfunc
nmap ;s :call <SID>SynStack()<CR>

"set colorcolumn=80 " vim 7.3

" my leader is ;
"
set showcmd
let mapleader=';'

" windows
"
" horizontal
map <leader>h <C-w>h
map <leader>l <C-w>l
"
" vertical
map <leader>j <C-w>j
map <leader>k <C-w>k
"
" split
map \ :split<CR>
map @ <C-w>+
map - <C-w>-

" :q and :w
" there is also ZZ for :q
map <leader>q :q<CR>
map <leader>w :w<CR>

" home / end
"map ;k gg
"map ;j G

"map ;; :e #<CR>

function! <SID>DoubleSemiColon()
  if exists('b:NERDTreeRoot') && winnr() == 1
    "call feedkeys("oT")
    call feedkeys("gg")
  else
    buffer #
  endif
endfunction
map <silent> <leader>; :call <SID>DoubleSemiColon()<CR>

map <silent> <leader>n :n<CR>
map <silent> <leader>c :cclose<CR>

map <silent> <leader>b :buffers<CR>
"map <silent> <leader>b :buffers<CR>:buffer<Space>
map <silent> <leader>1 :e #1<CR>
map <silent> <leader>2 :e #2<CR>
map <silent> <leader>3 :e #3<CR>
map <silent> <leader>4 :e #4<CR>
map <silent> <leader>5 :e #5<CR>
map <silent> <leader>6 :e #6<CR>
map <silent> <leader>7 :e #7<CR>
map <silent> <leader>8 :e #8<CR>
map <silent> <leader>9 :e #9<CR>
map <silent> <leader>a 0w

imap <C-j> <ESC>

" nerd tree
"
" alias vit='vim -c ":NERDTreeToggle"'
"
"map <silent> <C-n> :NERDTreeToggle<CR>
"map <silent> <Nul> :NERDTreeToggle<CR>
  "<Nul> is control-space
map <silent> T :NERDTreeToggle<CR>
map <silent> ff :NERDTreeToggle<CR>
"map <silent> ff :NERDTreeFind<CR>

let NERDTreeMinimalUI=1
let NERDTreeDirArrows=0

"function TreeOrBufferToggle()
"  if exists('b:NERDTreeRoot')
"    "NERDTreeToggle
"    call feedkeys("o")
"  else
"    if winnr() == 2 || bufnr('#') == -1 || bufnr('#') == bufnr('%')
"      NERDTreeToggle
"    else
"      buffer #
"    endif
"  endif
"endfunction
"map <silent> <space> :call TreeOrBufferToggle()<CR>
"map <silent> ;; :call TreeOrBufferToggle()<CR>

" pgup / pgdown
map <silent> <space> <C-d>
"map <silent> , <C-u>

" alternate buffer
"map <silent> <space> :e #<CR>

" search
set incsearch
set hlsearch
map <silent> _ :nohlsearch<CR>
"nohlsearch

function! <SID>Grep(regex)
  execute "vimgrep /".a:regex."/j ./**/*.rb"
  copen 20
endfunction
command! -nargs=1 G :call <SID>Grep('<args>')

" inspiration : http://vim.wikia.com/wiki/Find_files_in_subdirectories
"
function! <SID>Find(fragment)
  let l:result = system("find . -name '*".a:fragment."*' 2> /dev/null | head -1")
  execute "e ".l:result
endfunction
command! -nargs=1 F :call <SID>Find('<args>')

" Ctrl-Paste
"
map <silent> <C-p> :r ! pbpaste<CR>

" Copy
"
command! -nargs=0 C :silent w ! pbcopy

" Ctrl-n
"
"map <silent> <C-n> :set nu<CR>

map <silent> <leader>/ :w<CR>:e ~/scratch.txt<CR>

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

