" Vim syntax file
" Language:	HP-41
" Version:	0.8
" Maintainer:	Geir Isene
" Last Change:	2012-02-05
" Filenames:    *.41
" URL:		http://isene.com/

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syntax match  hp41LineNumber	"^ *[0-9]*"
"syntax match  hp41Cond		" [A-Z<>=0-9].\{-}?[A-Z0-9]\{-}\( \|$\)"
syntax match  hp41Comment	";.*"
syntax match  hp41Alpha		"\".*\""
syntax match  hp41LBL		".\=LBL.*"      contains=hp41Alpha,hp41Comment
syntax match  hp41GTO		" GTO .*"       contains=hp41Alpha,hp41Comment
syntax match  hp41XEQ		" XEQ .*"       contains=hp41Alpha,hp41Comment
syntax match  hp41RTN		" RTN"
syntax match  hp41END		" END"

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_crontab_syn_inits")
  if version < 508
    let did_crontab_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink hp41LineNumber		Number
  HiLink hp41LBL		Label
  HiLink hp41GTO		Structure
  HiLink hp41XEQ		Structure
  HiLink hp41RTN		Define
  HiLink hp41END		Define
  HiLink hp41Alpha		Function
  HiLink hp41Comment		Comment
"  HiLink hp41Cond		Comment

  delcommand HiLink
endif

let b:current_syntax = "hp41"

" vim: ts=8
