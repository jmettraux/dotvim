
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

function! JmDetermineTreePathAndLine()

  let n = line('.')
  let last = '................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................'
  let elts = []

  while n > 0

    let l = getline(n)

    let m = matchlist(l, '\v^(.{-1,})( +([0-9]+\.)?[0-9]+[BKMGTPE]?)?$')
      " .{-1,} is non-greedy
    if empty(m) == 0 | let l = m[1] | endif

    let m = matchlist(l, '\v^([│├─└  |`-]*)(.+)$')

    if empty(m) == 1 | let elts = [ l ] + elts | break | endif

    let lspace = substitute(m[1], ' ', '', 'g')
    if len(lspace) == 0 | let elts = [ l ] + elts | break | endif

    let left = substitute(m[1], '└', '├', 'g')
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

  return [ path, line ]
endfunction " JmDetermineTreePathAndLine

function! JmOpenFile(path, line)

  let n = bufnr(a:path)
  if n > -1
    exe 'b ' . n
  elseif isdirectory(a:path)
    call JmShowTree(a:path)
  else
    exe 'e ' . a:path
  endif

  if a:line > 0 | call feedkeys(a:line . 'G') | endif
endfunction " JmOpenFile

function! JmOpenTreeFile()

  let l = getline('.')
  let m = matchlist(l, '\v  \/ (["''].+)$')
  if empty(m) == 1 | let m = matchlist(l, '\v  \/ ''([^'']+)'' +(.+)$') | endif

  if empty(m) == 1
    let pl = JmDetermineTreePathAndLine()
    call JmOpenFile(pl[0], pl[1])
  else
    call JmVg(m[1])
  endif
endfunction " JmOpenTreeFile

