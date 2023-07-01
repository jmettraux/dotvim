
#
# fuzzer.rb

require 'io/console'

rows, cols = IO.console.winsize

lines = (File.readlines(ARGV[0]) rescue [ nil, nil, nil ])

fs = Dir['**/*.{js,rb,yaml,slim,scss,css,md,vim,sh,fish}'].sort
  # TODO make configurable

fi = (lines[1] || '').strip
li = (lines[2] || 0).to_i
pre = nil

def d_size(path)
  i = File.size(path)
  [ '', 'K', 'M', 'G', 'T' ].each do |n|
    return "#{i.to_i}#{n}" if i < 1024
    i = i / 1024.0
  end
  '-1'
end
def d_lines(path)
  "#{(File.read(path).size rescue -1)}l"
end
def d_diff(path)
  nil
end
  #
def detail(path)
  $details ||= {}
  $details[path] ||= {
    size: d_size(path), lines: d_lines(path), diff: d_diff(path) }
end

dcol = '92' # directory colour
fcol = '32' # filename colour
scol = '90' # slash colour
ocol = '93' # dot color
tcol = '90' # detail color

path = nil

loop do

  fs1 =
    fi == '' ? fs :
    fs.select { |f| f.downcase.index(fi) }
  fs1 = fs1[0, rows - 1]

  print "[2J" # clear

  fs1.each_with_index do |f, i|
    d = detail(f)
    print "[#{2 + i};1H[0;0m  "
    color = i == li ? "[1;#{dcol};7m" : "[#{dcol}m"
    print color
    t = f[0, cols - 2]
    tt = t.split('/')
    tt[-1] = "[#{fcol}m#{tt[-1].split('.').join("[#{ocol}m.[#{fcol}m")}"
    print tt.join("[#{scol}m/#{color}")
    print "  [#{tcol}m#{d[:size]} #{d[:lines]}"
  end

  print "[1;1H"
  print "[0;0m"
  print fi

  c = $stdin.raw { |io| io.readpartial(4) }

  if pre == ':'
    if c == 'q'
      path = ''; break
    end
  end
  pre = nil

  # TODO "/" to jump to next directory

  if c == "\e" # Escape
    path = ''; break
  elsif c == "\r" || c == "\n" # Return / Enter
    path = fs1[li]; break
  elsif c == "\x7F" # Backspace
    fi = fi[0..-2]; li = 0
  elsif c == "\e[A" || c == 'k' # up
    li = li - 1; li = 0 if li < 1
  elsif c == "\e[B" || c == 'j' # down
    li = li + 1; li = fs1.length - 1 unless fs1[li]
  elsif c == 'G'
    li = fs1.length - 1
  elsif c == "\t" || c == '/' # Tab / Slash
    if li == fs1.length - 1
      li = 0
    else
      dir = File.dirname(fs1[li])
      while cu = fs1[li]
        break if File.dirname(cu) != dir
        li = li + 1
      end
      li = fs1.length - 1 unless fs1[li]
    end
  elsif c == "\e[3~" # Delete
    fi = ''; li = 0
  elsif c.length > 1
    p c; sleep 0.7
  elsif c == ':'
    pre = ':'
  elsif ';'.index(c)
    # ignore
  else
    fi = fi + c.downcase; li = 0
  end

#rescue => err
#  p err
end

print "[2J" # clear

File.open(ARGV[0], 'wb') { |f| f.puts([ path, fi, li.to_s ].join("\n")) }

