
au BufEnter spec/*_spec.rb,spec/**/*_spec.rb :set updatetime=700
au CursorHold,BufWrite spec/*_spec.rb,spec/**/*_spec.rb :call writefile([ expand('%') . ':' . line('.'), "\n" ], '.vimspec', 'b')

