
" with help from http://stackoverflow.com/questions/4478891
"
function! s:Strip(s)

  return substitute(a:s, '^\s*\(.*\)\s*$', '\1', '')
endfunction " Strip

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
endfunction " ExtractPatternAndRest

" inspiration: http://stackoverflow.com/questions/10493452
"
function! s:Vg(args)

  if &mod == 1 | echoerr "Current buffer has unsaved changes." | return | endif

  let pr = s:ExtractPatternAndRest(a:args)
  let rest = pr[1] == '' ? '.' : pr[1]
  let fn = tempname() . '--' . JmNtr(pr[0]) . '--' . JmNtr(rest) . '.greprout'

  exe 'silent e ' . fn
  exe '%d_'
  exe "silent r! echo '== :Vg " . pr[0] . " " . rest . "'"
  exe "Clean"
  exe 'r! echo ""'
  exe 'silent r! grep -R -n --exclude-dir=.git --exclude-dir=tmp --exclude=.viminfo ' . pr[0] . ' ' . rest
  exe 'r! echo ""'
  exe 'g/: No such file or directory/d_'
  let g:groPattern = pr[0]
  setlocal syntax=greprout
  "call feedkeys('4G')
  normal 4G
  silent write
  nmap <buffer> o gF
  nmap <buffer> <space> gF
  nmap <buffer> <CR> gF
  "nmap <buffer> <leader>; gF
    " no, keep it for switching to alternate buffer
endfunction
au BufRead *.greprout set filetype=greprout

"command! -nargs=1 Vg :! grep -R -n --exclude-dir=.git <args>
"command! -nargs=* Vg :call <SID>Vg(<f-args>)
command! -nargs=* -complete=file Vg :call <SID>Vg(<q-args>)

"nnoremap <leader>q "zyw:exe ":call <SID>Vg(\"" . @z . "\")"<CR>
"nnoremap <leader>q "zyw:exe ":echo \"" . @z . "\""<CR>
"nnoremap <leader>g "zyw:exe ":call <SID>Vg(" . string(@z) . ")"<CR>
nnoremap <leader>g "zyw:exe ":call <SID>Vg('" . @z . " lib/ src/')"<CR>

