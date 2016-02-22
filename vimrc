
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

nnoremap <leader><TAB> i<C-v><TAB><ESC>


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

"" :q and :w
"" there is also ZZ for :q
"nnoremap <leader>q :q<CR>
"nnoremap <leader>w :w<CR>

nnoremap <leader>g <C-o>
nnoremap <leader>gg <C-o>

let g:jmAlt = 1
function! <SID>JmBufLeave()
  if &filetype !=# 'netrw'
    let g:jmAlt = bufnr('%')
  end
endfunction
function! <SID>JmBufAlt()
  exe "buffer " . g:jmAlt
endfunction
"
au BufLeave * :call <SID>JmBufLeave()
"
nnoremap <silent> <leader>; :call <SID>JmBufAlt()<CR>

nnoremap <silent> <leader>n :n<CR>
"nnoremap <silent> <leader>c :only!<CR>

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
"nnoremap <silent> <leader>a 0w

"nnoremap <silent> <leader>t /TODO<CR>
" TODO: pop that search when done

nnoremap <silent> <leader>u :setlocal number!<CR>

"nnoremap <silent> <leader>m ma
nnoremap <silent> <leader>a g'a
nnoremap <silent> <leader>y y'a
nnoremap <silent> <leader>d d'a

inoremap <C-j> <ESC>

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
    call feedkeys('1G/^[^.]:silent! /^| ' . dir . '\/')
  endfor
  call feedkeys('1G/^[^.]/^| \(' . join(a:dirs, '\|') . '\/\)')
  call feedkeys(':nohlsearch')
endfunction


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

" with help from http://stackoverflow.com/questions/4478891
"
function! s:Strip(s)

  return substitute(a:s, '^\s*\(.*\)\s*$', '\1', '')
endfunction

function! s:ExtractPatternAndRest(s)

  let s = s:Strip(a:s)

  let patt = ''
  let rest = ''

  let c = s[0]

  if c == '"'
    let patt = c . split(s, c)[0] . c
    let rest = s[strlen(patt) + 1:]
  elseif c == "'"
    let patt = c . split(s, c)[0] . c
    let rest = s[strlen(patt) + 1:]
  else
    let patt = string(split(s, ' ')[0])
    let rest = s[strlen(patt) - 2:]
  endif

  return [ patt, s:Strip(rest) ]
endfunction

" inspiration: http://stackoverflow.com/questions/10493452
"
function! s:Ak(args)

  if &mod == 1
    echoerr "Current buffer has unsaved changes. Aborting search."
    return
  end

  let pr = s:ExtractPatternAndRest(a:args)
  let rest = pr[1] == '' ? '.' : pr[1]

  exe 'e ' . tempname() . '.greprout'
  exe '%d'
  exe "r! echo '== :Ak " . pr[0] . " " . rest . "'"
  exe "Clean"
  exe 'r! echo ""'
  exe 'r! grep -R -n --exclude-dir=.git --exclude-dir=tmp ' . pr[0] . ' ' . rest
  exe 'r! echo ""'
  let g:groPattern = pr[0]
  setlocal syntax=greprout
  call feedkeys('4G')
  write
  nmap <buffer> o gF
  nmap <buffer> <space> gF
  nmap <buffer> <CR> gF
  "nmap <buffer> <leader>; gF
    " no, keep it for switching to alternate buffer
endfunction

au BufRead *.greprout set filetype=greprout


nnoremap <leader>f gF

"command! -nargs=1 Ak :! grep -R -n --exclude-dir=.git <args>
"command! -nargs=* Ak :call <SID>Ak(<f-args>)
command! -nargs=* Ak :call <SID>Ak(<q-args>)

"nnoremap <leader>q "zyw:exe ":call <SID>Ak(\"" . @z . "\")"<CR>
"nnoremap <leader>q "zyw:exe ":echo \"" . @z . "\""<CR>
nnoremap <leader>q "zyw:exe ":call <SID>Ak(" . string(@z) . ")"<CR>


function! s:ListOld()
  let fn = tempname() . '.listold'
  exe 'e ' . fn
  exe 'redir @z'
  exe 'silent bro ol'
  exe 'redir END'
  exe 'put=@z'
  exe 'g/^[^0-9]/d'
  exe '%s/^[0-9]\+: //'
  exe 'g/^$/d'
  exe 'g/^[^~]/d'
  exe 'g/EDITMSG/d'
  exe 'g/NetrwTreeListing/d'
  setlocal syntax=listold
  call feedkeys("1GO== ListOldj")
  call feedkeys(":w")
  nmap <buffer> o gF
  nmap <buffer> <space> gF
  nmap <buffer> <CR> gF
endfunction
command! -nargs=0 ListOld :call <SID>ListOld()
nnoremap <silent> <leader>o :call <SID>ListOld()<CR>

au BufRead *.listold set filetype=listold


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

" make
"
nnoremap <leader>m :!make<CR>

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
set exrc
set secure


"
" g CTRL-g to display offsets
"


