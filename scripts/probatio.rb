
#
# .vim/scripts/probatio.rb

if ARGV[0] == 'errors'

  Kernel.eval(File.read('.probatio-output.rb'))[:failures].each do |f|
    puts "#{f[:p]}:#{f[:l]}"
  end
end

