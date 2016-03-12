
" MIT license

"syn match lioTitle '^== .\+'
"syn match lioPath '^\~.\+'
syn match lioFilename '\.\/[^:]\+:[0-9]\+'
syn match Error 'Failures\?'
syn match Error 'Errors\?'

let b:current_syntax = "rspecout"

