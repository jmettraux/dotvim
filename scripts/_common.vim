
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

function! JmOpenTreeFile()

  let n = line('.')
  let last = '................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................'
  let elts = []

  while n > 0
    let l = getline(n)
    let m = matchlist(l, '\v^([│├─└  ]+) (.+)$')
    if empty(m) == 1 | let elts = [ l ] + elts | break | endif
    let left = substitute(m[1], '└', '├', 'g')
    let right = m[2]
    let n = n - 1
    if left == last | continue | endif
    if len(left) > len(last) | continue | endif
    let last = left
    let elts = [ right ] + elts
  endwhile

  let path = join(elts, '/')
  let path = substitute(path, '\v\/\/+', '/', 'g')
  let line = 'no'

  let m = matchlist(path, '\v^([^:]+):(\d+)')
  if empty(m) == 0
    let path = m[1]
    let line = m[2]
  endif

  exe 'e ' . path
  if line != 'no' | call feedkeys(line . 'G') | endif
endfunction " OpenTreeFile

