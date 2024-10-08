
function! s:ExtractPatternAndRest(s)

  let s = JmStrip(a:s)

  let patt = ''
  let patv = ''
  let rest = ''

  let c = s[0]
  let v = '\v'

  if c == '"'
    let patt = c . split(s, c)[0] . c
    let patv = c . v . split(s, c)[0] . c
    let rest = s[strlen(patt) + 1:]
  elseif c == "'"
    let patt = c . split(s, c)[0] . c
    let patv = c . v . split(s, c)[0] . c
    let rest = s[strlen(patt) + 1:]
  else
    let patt = string(split(s, ' ')[0])
    let patv = string(v . split(s, ' ')[0])
    let rest = s[strlen(patt) - 2:]
  endif

  return [ patt, patv, JmStrip(rest) ]
endfunction " ExtractPatternAndRest

function! s:GrepOpenFile()

  let n = line('.')
  let l = getline(n)
  let r = '\v^ *([0-9]+)\|'
  let m = matchlist(l, r)

  if empty(m) == 1
    call JmOpenFile(l, -1)
  else
    let ln = str2nr(m[1])
    while n > 1
      let l = getline(n - 1)
      let m = matchlist(l, r)
      if empty(m) == 1 | break | endif
      let n = n - 1
    endwhile
    call JmOpenFile(l, ln)
  endif
endfunction " GrepOpenFile

" inspiration: http://stackoverflow.com/questions/10493452
"
function! JmVg(args)

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let pr = s:ExtractPatternAndRest(a:args)
  let rest = pr[2] == '' ? '.' : pr[2]
  "let fn = tempname() . '--' . JmNtr(pr[0]) . '--' . JmNtr(rest) . '.greprout'
  let fn = '_g___' . JmNtr(pr[0]) . '__' . JmNtr(rest)

  "let bn = bufnr(fn)
  let bn = JmBufferNumber(fn)

  if bn > -1 | exe '' . bn . 'bwipeout!' | endif
    " close previous buffer if any

  exe 'new | only'
    " | only makes it full window
  exe 'silent file ' . fn
    " replace buffer name

  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  "setlocal nobuflisted
  setlocal cursorline

  exe '%d_'
  exe "silent r! echo '== :Vg " . pr[0] . " " . rest . "'"
  exe "Clean"
  exe 'silent r! ' . g:_python . ' ~/.vim/scripts/grep.py ' . shellescape(pr[0]) . ' ' . shellescape(rest) . ' ' . g:uname
  let g:groPattern = pr[1]
  setlocal syntax=greprout
  setlocal filetype=greprout
  normal 4G
  setlocal nomodifiable

  nnoremap <buffer> o :call <SID>GrepOpenFile()<CR>
  nnoremap <buffer> <space> :call <SID>GrepOpenFile()<CR>
  nnoremap <buffer> <CR> :call <SID>GrepOpenFile()<CR>
  exe 'nnoremap <buffer> r :call JmVg(' . string(a:args) . ')<CR>'
endfunction " JmVg

"command! -nargs=1 Vg :! grep -R -n --exclude-dir=.git <args>
"command! -nargs=* Vg :call <SID>Vg(<f-args>)
command! -nargs=* -complete=file Vg :call JmVg(<q-args>)

function! s:VgSrc(args)

"  if !empty(glob("lib"))
"    call JmVg(a:args . " lib")
"  elseif !empty(glob("src"))
"    call JmVg(a:args . " src")
"  else
"    call JmVg(a:args . " .")
"  endif

  call JmVg(a:args . " " . split(fnamemodify(expand("%"), ":~:."), "/")[0])
    " may be spec/ scripts/ lib/ src/ ... whatever is the first path element...
endfunction " s:VgSrc

"nnoremap <leader>q "zyw:exe ":call <SID>Vg(\"" . @z . "\")"<CR>
"nnoremap <leader>q "zyw:exe ":echo \"" . @z . "\""<CR>
"nnoremap <leader>g "zyw:exe ":call <SID>Vg(" . string(@z) . ")"<CR>
  "
"nnoremap <leader>g "zyw:exe ":call <SID>Vg('" . @z . " lib/ src/')"<CR>
nnoremap <leader>g wb"zyw:exe ":call <SID>VgSrc('" . @z . "')"<CR>

