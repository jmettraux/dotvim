
#
# fuzzer.rb

require 'io/console'

rows, cols = IO.console.winsize

fs = Dir['**/*.{js,rb,yaml,slim,scss,css,md,vim}'].sort
fi = ''
li = 0

dcol = '92' # directory colour
fcol = '32' # filename colour
scol = '90' # slash colour
ocol = '93' # dot color

loop do

  fs1 =
    fi == '' ? fs :
    fs.select { |f| f.downcase.index(fi) }

  print "[2J"

  print"[2;1H"
  fs1[0, rows - 2].each_with_index do |f, i|
    print "[0;0m"
    print '  '
    color = i == li ? "[1;#{dcol};7m" : "[#{dcol}m"
    print color
    t = f[0, cols - 2]
    tt = t.split('/')
    tt[-1] = "[#{fcol}m#{tt[-1].split('.').join("[#{ocol}m.[#{fcol}m")}"
    puts tt.join("[#{scol}m/#{color}")
  end

  print "[1;1H"
  print "[0;0m"
  print fi

  c = STDIN.raw { |io| io.readpartial(4) }

  if c == "\e" # Escape
    fi = ''; break
  elsif c == "\r" || c == "\n" # Return / Enter
    fi = fs1[li]; break
  elsif c == "\x7F" # Backspace
    fi = fi[0..-2]; li = 0
  elsif c == "\e[A" || c == 'k' # up
    li = li - 1; li = 0 if li < 1
  elsif c == "\e[B" || c == 'j' # down
    li = li + 1; li = fs1.length - 1 if li > fs1.length - 2
  elsif c == "\e3~" # Delete
    fi = ''; li = 0
  elsif c.length > 1
    p c; sleep 0.7
  elsif ';'.index(c)
    # ignore
  else
    fi = fi + c.downcase; li = 0
  end
#rescue => err
#  p err
end

File.open(ARGV[0], 'wb') { |f| f.write(fi) }

