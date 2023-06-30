#! /usr/bin/env ruby30

#p ARGV

require 'io/console'

rows, cols = IO.console.winsize

fs = Dir['**/*.{js,rb,yaml,slim,scss,css,md,vim}'].sort
fi = ''

loop do
  fs1 =
    fi == '' ? fs :
    fs.select { |f| f.downcase.index(fi) }
  print "[2J"
  print"[2;1H"
  fs1[0, rows - 2].each do |f|
    print "[32m"
    puts f
  end
  print "[1;1H"
  print "[0;0m"
  print fi

  c = STDIN.raw { |io| io.readpartial(4) }

  break if c == "\e"
  #p c; sleep 1

  if c == "\x7F"
    fi = fi[0..-2]
  elsif c.length > 1
    p c; sleep 0.5
  else
    fi = fi + c
  end

#rescue => err
#  p err
end

