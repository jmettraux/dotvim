
" MIT licensed

  " (<pattern>)@<=<match>  ~~~ positive lookbehind
  " <match>(<pattern>)@=   ~~~ positive lookahead
  " (<pattern>)@!<match>   ~~~ negative lookbehind
  " <match>(<pattern>)@!   ~~~ negative lookahead

hi! bufEqualEqual cterm=NONE ctermfg=grey ctermbg=16
hi! bufEqualCount cterm=NONE ctermfg=darkgrey ctermbg=16
hi! bufBufferNumber cterm=NONE ctermfg=darkgrey ctermbg=16
hi! bufGrepRex cterm=NONE ctermfg=green ctermbg=16
hi! bufGrepDir cterm=NONE ctermfg=darkgrey ctermbg=16
hi! bufGrepSlash cterm=NONE ctermfg=darkgrey ctermbg=16
hi! bufRecentSize cterm=NONE ctermfg=238 ctermbg=16
hi! bufRecentLines cterm=NONE ctermfg=darkgrey ctermbg=16
hi! bufRecentAge cterm=NONE ctermfg=238 ctermbg=16

hi! bufRecentGit cterm=NONE ctermfg=white ctermbg=16
hi! bufGitStatus cterm=NONE ctermfg=white ctermbg=16
hi! bufGitStats cterm=NONE ctermfg=darkgrey ctermbg=16

hi! bufFileName cterm=NONE ctermfg=darkyellow ctermbg=16
hi! bufLineNumber cterm=NONE ctermfg=darkgrey ctermbg=16

hi! bufSlash cterm=NONE ctermfg=darkgrey ctermbg=16
hi! bufDot cterm=NONE ctermfg=darkgrey ctermbg=16
hi! bufDir cterm=NONE ctermfg=darkgreen ctermbg=16
hi! bufExt cterm=NONE ctermfg=green ctermbg=16

hi! bufGitM cterm=bold ctermfg=darkgrey ctermbg=16
hi! bufGitA cterm=bold ctermfg=green ctermbg=16
hi! bufGitD cterm=bold ctermfg=red ctermbg=16
hi! bufGitR cterm=bold ctermfg=darkgreen ctermbg=16

hi def link bufComment Comment

syn match bufShort '\v^[^ =].+$' contains=bufFileName

syn match bufRecentLine '\v *.+$' contains=bufRecentName,bufRecentSize,bufRecentLines,bufRecentAge,bufRecentGit,bufComment
syn match bufFileAndLine '\v^[^ ][^ :]+:[0-9]+$' contains=bufFileName,bufLineNumber

syn match bufEqualEqual '\v^\=\= .+' contains=bufEqualCount
syn match bufEqualCount '\v\([0-9]+\)' contained

syn match bufBufferLine '\v^[^:].+:[0-9]+ +[0-9]+$' contains=bufFileName,bufLineNumber,bufBufferNumber

syn match bufGrepLine '\v^  \/ .+$' contains=bufGrepRex,bufGrepDir
syn match bufGrepRex '\v^  \/ [''"][^''"]+[''"]' contained contains=bufGrepSlash
syn match bufGrepDir '\v [^ ]+\/$' contained
syn match bufGrepSlash '\/' contained

syn match bufRecentName '\v^ *.+( [0-9]+(\.[0-9]+)?[PTMKB])@=' contained keepend contains=bufFileName
"syn match bufRecentName '\v^ *[^ ]+$' contained keepend contains=bufFileName
syn match bufRecentName '\v^ *[^ ]+' contained keepend contains=bufFileName
syn match bufRecentSize '\v [0-9]+(\.[0-9]+)?[PTMKB]' contained
syn match bufRecentLines '\v [0-9]+L' contained
syn match bufRecentAge '\v ([0-9]+[dhms])+' contained
syn match bufRecentGit '\v\+[0-9]+\-[0-9]+' contained

syn match bufComment '\v#.*$' contained

syn match bufFileName '\v^[^:|]+' contained contains=bufSlash,bufDot,bufDir,bufExt
syn match bufLineNumber '\v:[0-9]+' contained

syn match bufBufferNumber '\v[0-9]+$' contained

syn match bufSlash '/' contained
syn match bufDot '\v\.' contained
syn match bufDir '\v[^\/]+(\/)@=' contained

syn match bufGitLine '\v[^ ][^|]+ \| .+$' contains=bufFileName,bufGitStatus
syn match bufGitStatus '\v[MADR]\+[0-9]+\-[0-9]+' contained contains=bufGitM,bufGitA,bufGitD,bufGitR
syn match bufGitStats '\v^  [0-9]+ .+$'

syn match bufGitM '\vM' contained
syn match bufGitA '\vA' contained
syn match bufGitD '\vD' contained
syn match bufGitR '\vR' contained

syn match bufExt '\v([a-zA-Z0-9])@<=\.[a-zA-Z]+( |:)@=' contained


let b:current_syntax = "buffers"

