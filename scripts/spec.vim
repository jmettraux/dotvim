
au BufEnter test/*_test.rb,test/**/*_test.rb :set updatetime=700
au BufEnter spec/*_spec.rb,spec/**/*_spec.rb :set updatetime=700

au BufEnter,CursorHold,BufWrite test/*_test.rb,test/**/*_test.rb :call writefile([ expand('%') . ':' . line('.') ], '.test-point', 'b')
au BufEnter,CursorHold,BufWrite spec/*_spec.rb,spec/**/*_spec.rb :call writefile([ expand('%') . ':' . line('.') ], '.vimspec', 'b')

