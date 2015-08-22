
"
" my .vimrc, sorry, nothing fancy here
"
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

let mapleader=';'

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

set history=147
set cmdwinheight=20
  " q: q/ q?

" disabling the pulldown autocomplete thinggy
inoremap <C-n> <nop>

au BufRead *.go set filetype=go
au BufRead *.rad set filetype=radial
au BufRead *.radial set filetype=radial
au BufRead *.erb set filetype=eruby
au BufRead *.ru set filetype=ruby
au BufRead *.rake set filetype=ruby
au BufRead *.rconf set filetype=ruby

au BufNewFile,BufRead *.md set filetype=mkd

au BufNewFile,BufRead *.liquid set ft=liquid
au BufNewFile,BufRead */_layouts/*.html set ft=liquid

au BufNewFile,BufRead *.html,*.xml,*.textile
  \ if getline(1) == '---' | set ft=liquid | endif

au BufNewFile,BufRead Gemfile setlocal ft=ruby

au FileType java set shiftwidth=4
au FileType java set autoindent
au FileType java set noexpandtab
au FileType java set tabstop=4
au FileType java set shiftwidth=4

au FileType ruby set shiftwidth=2
"filetype plugin indent on
filetype on

" temp
"
"nnoremap q :%s/    /  /g<ENTER>
"nnoremap t :%s/ *$//<ENTER>
command! -nargs=0 Clean :silent %s/\v\s*$// | nohlsearch
command! -nargs=0 Mkd :silent :set filetype=mkd

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

" Show syntax highlighting groups for word under cursor
"
" from http://vimcasts.org/episodes/creating-colorschemes-for-vim/
"
function! <SID>SynStack()

  if !exists("*synstack")
    return
  endif

  for x in map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    redi => out
    silent exe "hi" x
    redi END
    exe "hi" x
    let link = matchstr(out, ' links to \zs.*\ze$')
    if !empty(link)
      exe "hi" link
    end
  endfor

  echo '.'

endfunc

nnoremap <silent> ;s :call <SID>SynStack()<CR>


" windows
"
" horizontal
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l
"
" vertical
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
"
" split
"nnoremap \ :split<CR>
nnoremap @ <C-w>+
nnoremap - <C-w>-

" :q and :w
" there is also ZZ for :q
nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>

nnoremap <leader>g <C-o>
nnoremap <leader>gg <C-o>

nnoremap <silent> <leader>; :buffer #<CR>

nnoremap <silent> <leader>n :n<CR>

"nnoremap <silent> <leader>c :only!<CR>

nnoremap <silent> <leader>o :browse old<CR>

nnoremap <silent> <leader>b :buffers<CR>
nnoremap <silent> <leader>1 :e #1<CR>
nnoremap <silent> <leader>2 :e #2<CR>
nnoremap <silent> <leader>3 :e #3<CR>
nnoremap <silent> <leader>4 :e #4<CR>
nnoremap <silent> <leader>5 :e #5<CR>
nnoremap <silent> <leader>6 :e #6<CR>
nnoremap <silent> <leader>7 :e #7<CR>
nnoremap <silent> <leader>8 :e #8<CR>
nnoremap <silent> <leader>9 :e #9<CR>
nnoremap <silent> <leader>a 0w

"nnoremap <silent> <leader>t /TODO<CR>
" TODO: pop that search when done

nnoremap <silent> <leader>u :setlocal number!<CR>

"nnoremap <silent> <leader>m ma
"nnoremap <silent> <leader>g g'a
"nnoremap <silent> <leader>y y'a
"nnoremap <silent> <leader>d d'a

inoremap <C-j> <ESC>

" nerd tree
"
" alias vit='vim -c ":NERDTreeToggle"'
"
""nnoremap <silent> <C-n> :NERDTreeToggle<CR>
""nnoremap <silent> <Nul> :NERDTreeToggle<CR>
  "<Nul> is control-space
"nnoremap <silent> ff :NERDTreeToggle<CR>
""nnoremap <silent> ff :NERDTreeFind<CR>

"let NERDTreeMinimalUI=1
"let NERDTreeDirArrows=0

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
"nnoremap <silent> <space> :call TreeOrBufferToggle()<CR>
"nnoremap <silent> ;; :call TreeOrBufferToggle()<CR>

" netrw
"
" with lots of help from
" http://stackoverflow.com/questions/5006950/setting-netrw-like-nerdtree

" absolute width of netrw window
let g:netrw_winsize = -28

" do not display info on the top of window
let g:netrw_banner = 0

" tree-view
let g:netrw_liststyle = 3

" sort is affecting only: directories on the top, files below
let g:netrw_sort_sequence = '[\/]$,*'

" use the previous window to open file
let g:netrw_browse_split = 4
let g:netrw_altv = 1

function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore .
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
nnoremap <silent> ff :call ToggleVExplorer()<CR>

" close explorer if it's not the current buffer
function! CloseVExplorer()
  let cbn = bufnr('%')
  if cbn != t:expl_buf_num
    let ewn = bufwinnr(t:expl_buf_num)
    exec ewn . 'wincmd w'
    close
    unlet t:expl_buf_num
  endif
endfunction

function! NetrwRemap()
  nmap <buffer> o <CR>
  nmap <silent><buffer> <leader>; <CR>:call CloseVExplorer()<CR>
endfunction
au FileType netrw call NetrwRemap()

" pgup / pgdown
"
"nnoremap <silent> <space> <C-d>
"nnoremap <silent> , <C-u>

" search
"
set incsearch
set hlsearch
nnoremap <silent> _ :nohlsearch<CR>
nnoremap <silent> \ :nohlsearch<CR>

function! <SID>Grep(regex)
  exe 'vimgrep /'.a:regex.'/j ./**/*.rb'
  copen 20
endfunction
command! -nargs=1 G :call <SID>Grep('<args>')

" inspiration: http://vim.wikia.com/wiki/Find_files_in_subdirectories
"
function! <SID>Find(fragment)
  let l:result = system("find . -name '*".a:fragment."*' 2> /dev/null | head -1")
  exe 'e ' l:result
endfunction
command! -nargs=1 F :call <SID>Find('<args>')

" inspiration: http://stackoverflow.com/questions/10493452
"
function! <SID>Ak(pattern, ...)
  e .greprout
  exe '%d'
  exe "r! echo '== :Ak " . a:pattern . " " . join(a:000, ' ') . "'"
  exe "Clean"
  exe 'r! echo ""'
  exe 'r! grep -R -n --exclude-dir=.git ' a:pattern join(a:000, ' ')
  exe 'r! echo ""'
  write
  exe "syn match groPattern '" . a:pattern . "'"
  call feedkeys('4G')
endfunction

au BufRead .greprout set filetype=greprout

nnoremap <leader>f gF

"command! -nargs=1 Ak :! grep -R -n --exclude-dir=.git <args>
command! -nargs=* Ak :call <SID>Ak(<f-args>)


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

nnoremap <silent> <leader>tt :w<CR>:e ~/scratch.txt<CR>

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

" Git
"
nnoremap <leader>gu :!git status<CR>
nnoremap <leader>gl :!git log --graph --oneline --abbrev-commit --decorate<CR>
nnoremap <leader>ti :!tig<CR>

" exrc
"
set exrc
set secure

