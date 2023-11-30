
"
" colors/jm_flexoki.vim
"
" https://stephango.com/flexoki
"

" You can convert an RGB color code into a Vim color code using the following
" formula:
"
" ```
" vim_color = 16 + (36 * r / 255) + (6 * g / 255) + (b / 255)
" ```

" set termguicolors...

" ## Base tones
"
" | Value | Hex       | RGB             |
" | ----- | --------- | --------------- |
" | black | `#100F0F` | `16, 15, 15`    |
" | 950   | `#1C1B1A` | `28, 27, 26`    |
" | 900   | `#282726` | `40, 39, 38`    |
" | 850   | `#343331` | `52, 51, 49`    |
" | 800   | `#403E3C` | `64, 62, 60`    |
" | 700   | `#575653` | `87, 86, 83`    |
" | 600   | `#6F6E69` | `111, 110, 105` |
" | 500   | `#878580` | `135, 133, 128` |
" | 300   | `#B7B5AC` | `183, 181, 172` |
" | 200   | `#CECDC3` | `206, 205, 195` |
" | 150   | `#DAD8CE` | `218, 216, 206` |
" | 100   | `#E6E4D9` | `230, 228, 217` |
" | 50    | `#F2F0E5` | `242, 240, 229` |
" | paper | `#FFFCF0` | `255, 252, 240` |
"
" ## Colors
"
" ### Dark tones
"
" | Color   | Hex       | RGB            |
" | ------- | --------- | -------------- |
" | red     | `#AF3029` | `175, 48, 41`  |
" | orange  | `#BC5215` | `188, 82, 21`  |
" | yellow  | `#AD8301` | `173, 131, 1`  |
" | green   | `#66800B` | `102, 128, 11` |
" | cyan    | `#24837B` | `36, 131, 123` |
" | blue    | `#205EA6` | `32, 94, 166`  |
" | purple  | `#5E409D` | `94, 64, 157`  |
" | magenta | `#A02F6F` | `160, 47, 111` |
"
" ### Light tones
"
" | Color   | Hex       | RGB             |
" | ------- | --------- | --------------- |
" | red     | `#D14D41` | `209, 77, 65`   |
" | orange  | `#DA702C` | `218, 112, 44`  |
" | yellow  | `#D0A215` | `208, 162, 21`  |
" | green   | `#879A39` | `135, 154, 57`  |
" | cyan    | `#3AA99F` | `58, 169, 159`  |
" | blue    | `#4385BE` | `67, 133, 190`  |
" | purple  | `#8B7EC8` | `139, 126, 200` |
" | magenta | `#CE5D97` | `206, 93, 151`  |

" https://vi.stackexchange.com/questions/9754/how-to-change-vim-background-color-in-hex-code-or-rgb-color-code


set background=dark
syntax enable

let colors_name = "jm_flexoki"

if exists("syntax_on")
  syntax reset
endif

hi clear

if has('nvim') || has('termguicolors')
  let is_truecolor = 1
else
  let is_truecolor = has('gui_running')
endif

if is_truecolor

  "set t_Co=256
  set termguicolors

  let foki_black = "#100F0F"
  let foki_950   = "#1C1B1A"
  let foki_900   = "#282726"
  let foki_850   = "#343331"
  let foki_800   = "#403E3C"
  let foki_700   = "#575653"
  let foki_600   = "#6F6E69"
  let foki_500   = "#878580"
  let foki_300   = "#B7B5AC"
  let foki_200   = "#CECDC3"
  let foki_150   = "#DAD8CE"
  let foki_100   = "#E6E4D9"
  let foki_50    = "#F2F0E5"
  let foki_paper = "#FFFCF0"

  let foki_red     = "#AF3029"
  let foki_orange  = "#BC5215"
  let foki_yellow  = "#AD8301"
  let foki_green   = "#66800B"
  let foki_cyan    = "#24837B"
  let foki_blue    = "#205EA6"
  let foki_purple  = "#5E409D"
  let foki_magenta = "#A02F6F"

  " general
  "
  "hi! LineNr cterm=NONE ctermfg=239 ctermbg=235 " #606060 #323232
  hi! LineNr guifg=foki_150 guibg=foki_700
  "hi! StatusLine cterm=NONE ctermfg=245 ctermbg=235
  hi! StatusLine guifg=foki_50 guibg=foki_850
  hi! StatusLineNC cterm=NONE ctermfg=245 ctermbg=235
  "hi! StatusLine guifg=foki_ guibg=foki_

  " syntax highlight
  "
  hi! Normal cterm=NONE ctermfg=244 ctermbg=16 " #929292 black
  hi! Comment cterm=bold ctermfg=238 ctermbg=16 " #565656
  hi! Constant cterm=bold ctermfg=179 ctermbg=16 " #DEBA76
    hi! String cterm=bold ctermfg=191 ctermbg=16 " #DEF979
  hi! Identifier cterm=NONE ctermfg=71 ctermbg=16 " #73B874
    hi! Function cterm=NONE ctermfg=83 ctermbg=16 " #75F877
  hi! Statement cterm=NONE ctermfg=41 ctermbg=16 " #18D875
    hi! Keyword cterm=NONE ctermfg=76 ctermbg=16 " #74D822
  hi! PreProc cterm=NONE ctermfg=29 ctermbg=16 " #0D9672
  hi! Type cterm=NONE ctermfg=136 ctermbg=16 " #BC961B
  hi! Special cterm=NONE ctermfg=196 ctermbg=16 " #FD2517
    hi! Delimiter cterm=NONE ctermfg=196 ctermbg=16
  hi! Todo cterm=NONE ctermfg=16 ctermbg=41 " black #18D875

  " Quickfix
  "
  hi! qfLineNr cterm=NONE ctermfg=136 ctermbg=16

  " Search
  "
  hi! Search cterm=NONE ctermfg=29 ctermbg=255

  " NetRw
  "
  hi! Directory cterm=NONE ctermfg=136 ctermbg=16

else if match(&term, '-256color$') > -1
else
endif

