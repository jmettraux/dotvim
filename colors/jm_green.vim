
set background=dark
syntax enable

let colors_name = "jm_green"

if exists("syntax_on")
  syntax reset
endif

hi clear

" Solarized guidance
"
""     *Normal          anything
""     *Comment         any comment
""     *Constant        any constant
""        String          a string constant: "this is a string"
""        Character       a character constant: 'c', '\n'
""        Number          a number constant: 234, 0xff
""        Boolean         a boolean constant: TRUE, false
""        Float           a floating point constant: 2.3e10
""     *Identifier      any variable name
""        Function        function name (also: methods for classes)
""     *Statement       any statement
""        Conditional     if, then, else, endif, switch, etc.
""        Repeat          for, do, while, etc.
""        Label           case, default, etc.
""        Operator        "sizeof", "+", "*", etc.
""        Keyword         any other keyword
""        Exception       try, catch, throw
""     *PreProc         generic Preprocessor
""        Include         preprocessor #include
""        Define          preprocessor #define
""        Macro           same as Define
""        PreCondit       preprocessor #if, #else, #endif, etc.
""     *Type            int, long, char, etc.
""        StorageClass    static, register, volatile, etc.
""        Structure       struct, union, enum, etc.
""        Typedef         A typedef
""     *Special         any special symbol
""        SpecialChar     special character in a constant
""        Tag             you can use CTRL-] on this
""        Delimiter       character that needs attention
""        SpecialComment  special things inside a comment
""        Debug           debugging statements
""     *Underlined      text that stands out, HTML links
""     *Ignore          left blank, hidden  |hl-Ignore|
""     *Error           any erroneous construct
""     *Todo            anything that needs extra attention; mostly the
""                      keywords TODO FIXME and XXX

" let s:base03      = "234"
" let s:base02      = "235"
" let s:base01      = "239"
" let s:base00      = "240"
" let s:base0       = "244"
" let s:base1       = "245"
" let s:base2       = "187"
" let s:base3       = "230"
" let s:yellow      = "136"
" let s:orange      = "166"
" let s:red         = "124"
" let s:magenta     = "125"
" let s:violet      = "61"
" let s:blue        = "33"
" let s:cyan        = "37"
" let s:green       = "64"

if &term == 'xterm-256color'

  set t_Co=256

  " general
  " 
  hi! LineNr cterm=NONE ctermfg=239 ctermbg=235
  hi! StatusLine cterm=NONE ctermfg=245 ctermbg=235
  hi! StatusLineNC cterm=NONE ctermfg=245 ctermbg=235

  " syntax highlight
  " 
  hi! Normal cterm=NONE ctermfg=244 ctermbg=16
  hi! Comment cterm=bold ctermfg=238 ctermbg=16
  hi! Constant cterm=bold ctermfg=179 ctermbg=16
    hi! String cterm=bold ctermfg=191 ctermbg=16
  hi! Identifier cterm=NONE ctermfg=71 ctermbg=16
    hi! Function cterm=NONE ctermfg=83 ctermbg=16
  hi! Statement cterm=NONE ctermfg=41 ctermbg=16
    hi! Keyword cterm=NONE ctermfg=76 ctermbg=16
  hi! PreProc cterm=NONE ctermfg=29 ctermbg=16
  hi! Type cterm=None ctermfg=136 ctermbg=16
  hi! Special cterm=NONE ctermfg=196 ctermbg=16
    hi! Delimiter cterm=NONE ctermfg=196 ctermbg=16

  " NERDTree
  "
  hi! NERDTreeHelp cterm=NONE ctermfg=244 ctermbg=16
  hi! NERDTreePart cterm=NONE ctermfg=238 ctermbg=16
  hi! NERDTreePartFile cterm=NONE ctermfg=238 ctermbg=16
  "hi! NERDTreeDir cterm=NONE ctermfg=41 ctermbg=16
  hi! Directory cterm=NONE ctermfg=41 ctermbg=16
  hi! NERDTreeOpenable cterm=NONE ctermfg=136 ctermbg=16
  hi! NERDTreeClosable cterm=NONE ctermfg=136 ctermbg=16
  hi! NERDTreeExecFile cterm=NONE ctermfg=136 ctermbg=16

  " Quckfix
  "
  hi! qfLineNr cterm=NONE ctermfg=136 ctermbg=16

else

  set t_Co=16

  hi! LineNr ctermfg=DarkYellow
  hi! Comment cterm=bold ctermfg=DarkGray

endif

