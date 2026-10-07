
" scripts/fragment.vim

function! s:InsertFrag()

  let l:file = '.frag'

  if filereadable(l:file)
    let l:lines = readfile(l:file)
    if len(l:lines) >= 1
      let l:content = trim(l:lines[0])
      execute "normal! a" . l:content
    else
      echohl ErrorMsg
      echo "File empty: " . l:file
      echohl None
    endif
  else
    echohl ErrorMsg
    echo "File not found: " . l:file
    echohl None
  endif
endfunction

command! Frag call s:InsertFrag()

