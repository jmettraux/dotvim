
set background=dark
syntax enable

let colors_name = "jm_blue"

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

if &term == 'xterm-256color'

  set t_Co=256

  hi! LineNr cterm=NONE ctermfg=241 ctermbg=235
  hi! StatusLine cterm=NONE ctermfg=241 ctermbg=235

  hi! Normal cterm=NONE ctermfg=255 ctermbg=16

  hi! Comment cterm=bold ctermfg=238 ctermbg=16

  hi! Constant cterm=bold ctermfg=033 ctermbg=16
    hi! String cterm=bold ctermfg=084 ctermbg=16

  hi! Identifier cterm=NONE ctermfg=004 ctermbg=16
    hi! Function cterm=NONE ctermfg=004 ctermbg=16

  hi! Statement ctermfg=032
    hi! Keyword ctermfg=032

  hi! PreProc cterm=NONE ctermfg=069 ctermbg=16

  hi! Type cterm=None ctermfg=027 ctermbg=16

  hi! Special cterm=NONE ctermfg=014 ctermbg=16
    hi! Delimiter cterm=NONE ctermfg=014 ctermbg=16

else

  set t_Co=16

  hi! LineNr ctermfg=DarkYellow
  hi! Comment cterm=bold ctermfg=DarkGray

endif

