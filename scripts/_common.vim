
"
" _common.vim
"
" functions common to all the scripts/*.vim
"
" Nota bene: the :scriptnames command list all the scripts loaded by Vim,
" by load order

function! JmNtr(s)

  return substitute(a:s, '[^a-zA-Z0-9]', '_', 'g')
endfunction

"function! JmNtrDot(s)
"  let m = matchlist(a:s, '\v(\.[a-zA-Z0-9]+)?$')
"  let l = strlen(m[1])
"  return JmNtr(a:s[0:-(l + 1)]) . m[1]
"endfunction

function! JmStrip(s)

  return substitute(a:s, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

function! JmDetermineTreePathAndLine()

  let n = line('.')
  let last = '................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................'
  let elts = []

  while n > 0

    let l = getline(n)

    let m = matchlist(l, '\v^(.+) (new|untracked)$')
    if empty(m) == 0 | let l = m[1] | endif
      "
    let m = matchlist(l, '\v^(.+) (\+[0-9]+-[0-9]+)$')
    if empty(m) == 0 | let l = m[1] | endif
      "
    let m = matchlist(l, '\v^(.+) ([0-9]+[dhms])+$')
    if empty(m) == 0 | let l = m[1] | endif
      "
    let m = matchlist(l, '\v^(.+) ([0-9]+L)$')
    if empty(m) == 0 | let l = m[1] | endif
      "
    let m = matchlist(l, '\v^(.+) ([0-9]+(\.[0-9]+)?[BKMGTPE]?)$')
    if empty(m) == 0 | let l = m[1] | endif
      "
      " trim out git and size from the right side of the line

    let m = matchlist(l, '\v^([│├─└  |`-]*)(.+)$')
    if empty(m) == 1 | let elts = [ l ] + elts | break | endif

    let lspace = substitute(m[1], ' ', '', 'g')
    if len(lspace) == 0 | let elts = [ l ] + elts | break | endif

    let left = substitute(m[1], '└', '├', 'g')
    let left = substitute(left, '`', '|', 'g')
    let right = m[2]
    let n = n - 1
    if left == last | continue | endif

    if len(left) > len(last) | continue | endif

    let last = left
    let elts = [ right ] + elts
  endwhile

  let path = join(elts, '/')
  let path = substitute(path, '\v^[  ]+', '', '') " trim left
  let path = substitute(path, '\v\/\/+', '/', 'g') " turn // or /// into /
  let path = substitute(path, '\v +\| (.+)$', '', '') " cut trailing info
  let line = -1

  let m = matchlist(path, '\v^([^:]+):(\d+)')
  if empty(m) == 0
    let path = m[1]
    let line = str2nr(m[2])
  endif

  if path[0:1] == './' | let path = path[2:] | endif

  return [ path, line ]
endfunction " JmDetermineTreePathAndLine

function! JmBufferNumber(fname)

  return bufnr('^' . a:fname . '$')
    " wrap in regex to prevent partial matches!
endfunction " JmBufferNumber

function! JmOpenFile(path, line)

  let n = JmBufferNumber(a:path)
  if n > -1
    exe 'b ' . n
  elseif isdirectory(a:path)
    call JmShowTree(a:path)
  else
    exe 'e ' . a:path
  endif

  if a:line > 0 | call feedkeys(a:line . 'G') | endif
endfunction " JmOpenFile

"function! JmOpenTreeFile(mode='open')
function! JmOpenTreeFile(...)

  let mode = get(a:, 0, 'open')

  let l = getline('.')

  let m = matchlist(l, '\v\=\= (.+)$')
  if empty(m) != 1
    if match(m[1], '\v\.') > -1 | call JmOpenFile(m[1], 1) | endif
    return 0
  endif

  let m = matchlist(l, '\v  \/ (["''].+)$')
  if empty(m) == 1 | let m = matchlist(l, '\v  \/ ''([^'']+)'' +(.+)$') | endif

  if empty(m) == 1
    let pl = JmDetermineTreePathAndLine()
    let ex = tolower(fnamemodify(pl[0], ':e'))
    if index([ 'jpg', 'jpeg', 'gif', 'png', 'webp', 'bmp' ], ex) > -1
      if mode == 'edit'
        call system('gimp ' . pl[0])
      else
        call system('fe ' . pl[0])
      end
    else
      call JmOpenFile(pl[0], pl[1])
    endif
  else
    call JmVg(m[1])
  endif
endfunction " JmOpenTreeFile

function! JmDetermineSyntax(path)

  if a:path =~ "\.rb$" | return 'ruby' | endif
  if a:path =~ "\.js$" | return 'javascript' | endif
  if a:path =~ "\.py$" | return 'python' | endif
  if a:path =~ "\.md$" | return 'markdown' | endif
  if a:path =~ "\.vim$" | return 'vim' | endif
  if a:path =~ "\.html?$" | return 'html' | endif
  return ''
endfunction " JmDetermineSyntax

function! JmGitForFile(path)

  let dir = fnamemodify(a:path, ':h')

  let git = trim(system('cd ' . dir . ' && git rev-parse --show-toplevel'))
  if v:shell_error != 0
    let git = 'no / ' . a:path
  endif

  return git
endfunction " JmGitForFile


highlight JmRedEchoHighlight ctermfg=red ctermbg=none
highlight JmGreyEchoHighlight ctermfg=grey ctermbg=none
highlight JmGreenEchoHighlight ctermfg=green ctermbg=none

function! JmRedEcho(...)
  echohl JmRedEchoHighlight | echo join(a:000, ' ') | echohl None
endfunction
function! JmGreyEcho(...)
  echohl JmGreyEchoHighlight | echo join(a:000, ' ') | echohl None
endfunction
function! JmGreenEcho(...)
  echohl JmGreenEchoHighlight | echo join(a:000, ' ') | echohl None
endfunction

