
au BufEnter spec/*_spec.rb,spec/**/*_spec.rb :set updatetime=700
au BufEnter,CursorHold,BufWrite spec/*_spec.rb,spec/**/*_spec.rb :call writefile([ expand('%') . ':' . line('.') ], '.vimspec', 'b')

