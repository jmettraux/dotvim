#! /usr/bin/env ruby30

#p ARGV

require 'io/console'

rows, cols = IO.console.winsize

fs = Dir['**/*.{js,rb,yaml,slim,scss,css,md,vim}'].sort
fi = ''
li = 1

loop do
  fs1 =
    fi == '' ? fs :
    fs.select { |f| f.downcase.index(fi) }
  print "[2J"
  print"[2;1H"
  fs1[0, rows - 2].each_with_index do |f, i|
    print "[0;0m"
    if i == li
      print "[1;32;7m"
    else
      print "[32m"
    end
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
  elsif c == "\e[A"
    li = li - 1; li = 0 if li < 1
  elsif c == "\e[B"
    li = li + 1; li = fs1.length - 1 if li > fs1.length - 1
  elsif c.length > 1
    p c; sleep 0.5
  else
    fi = fi + c
  end

#rescue => err
#  p err
end

