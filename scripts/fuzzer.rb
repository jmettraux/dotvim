
#
# fuzzer.rb

require 'io/console'

rows, cols = IO.console.winsize

lines = (File.readlines(ARGV[0]) rescue [ nil, nil, nil ])
fi0 = ARGV[1]

suffixes = %w[
  js rb ru java pl py c go
  sh fish vim
  txt text md mdown markdown
  htm html slim haml
  css scss
  xml toml json yaml yml conf cnf
  flo ]

fs = (
  Dir["**/*.{#{suffixes.join(',')}}"] +
  Dir['**/*/']#.collect { |e| e + '/' }
    ).sort

hi = (lines[1] || '').strip.split('|')
hishow = false

fi =
  if fi0 && fi0 != ''
    fi0
  else
    fi1 = hi[0] || ''; hi.rotate!; fi1
  end

li = (lines[2] || 0).to_i
pre = nil

  # 15      11      app/views/wma/_dac_4_approvals.slim
  # 67      24      app/views/wma/_dac_5_assignment.slim
  # 1       1       app/views/wma/_dac_mandates.slim
  #
$git = `git diff --numstat`.strip.split("\n")
  .inject({}) { |h, l|
    ll = l.split("\t")
    h[ll.pop] = ll
    h }
      # FIXME git root might not be here...
$gits = `git ls-files`.strip.split("\n")

def d_size(path)
  i = File.size(path)
  [ '', 'K', 'M', 'G', 'T' ].each do |n|
    return "#{i.to_i}#{n}" if i < 1024
    i = i / 1024.0
  end
  '-1'
end
def d_lines(path)
  "#{(File.readlines(path).size rescue -1)}l"
end
def d_diff(path)
  g = $git[path]
  g ? "+#{g[0]}-#{g[1]}" : nil
end
def d_recent(path)
  (Time.now - File.mtime(path)) < 24 * 60 * 60
end
def d_git(path)
  $gits.include?(path)
end
  #
def detail(path)
  $details ||= {}
  $details[path] ||=
    File.directory?(path) ?
    { dir: true, recent: d_recent(path), git: true } :
    { size: d_size(path), lines: d_lines(path), diff: d_diff(path),
      recent: d_recent(path), git: d_git(path) }
end

def select(pat, files)
  return files if pat == ''
  pats = pat.split('*')
  if pats.length < 2
    files.select { |f|
      f.downcase.index(pat) }
  else
    files.select { |f|
      f1 = f.downcase;
      f1.start_with?(pats[0]) && f1.index(pats[1]) }
  end
end

dcol = '92' # directory colour
fcol = '32' # filename colour
scol = '90' # slash colour
ocol = '93' # dot color
tcol = '90' # detail color
gcol = '97' # git color
rcol = '2;33' # recent color

recent = '<<'

path = nil

loop do

  fs1 = select(fi, fs)[0, rows - 1]

  print "[2J" # clear

  fs1.each_with_index do |f, i|

    d = detail(f)

    print "[#{2 + i};1H[0;0m  "
    color = i == li ? "[1;#{dcol};7m" : "[#{dcol}m"
    print color

    t = f[0, cols - 2]
    tt = t.split('/')

    dot = i == li ? '.' : "[#{ocol}m.#{color}[#{fcol}m"
    tt[-1] = "[#{fcol}m#{tt[-1].split('.').join(dot)}" unless d[:dir]

    print tt.join("[#{scol}m/#{color}")

    print "[#{scol}m/#{color}" if d[:dir]
    print "  [#{tcol}m#{d[:size]} #{d[:lines]}" if d[:size]

    if d[:diff]
      print "  [#{gcol}m#{d[:diff]}"
    elsif ! d[:git]
      print "  [#{gcol}mng"
    end

    print "  [#{rcol}m#{recent}" if d[:recent]
  end

  print "[1;#{cols}H"
  print "[0;0m"
  print pre || ''

  print "[1;1H"
  if hishow
    print fi + '  '
    print hi.join(' ')[0, cols - fi.size - 2]
    print "[1;1H"
    print "[7m"
    print fi # ;-)
    print "[0;0m"
    hishow = false
  else
    print "[0;0m"
    print fi
  end

  c = $stdin.raw { |io| io.readpartial(4) }

  if pre == ':'
    if c == 'q'
      path = ''; break
    #elsif c == ':'
    #  c = '['
    end
  elsif pre == ';'
    if c == ';'
      path = ''; break
    elsif c == 'b'
      path = '(buffers)'; break
    elsif c == 'd'
      path = '(diff)'; break
    elsif c == 'l'
      path = '(log)'; break
    elsif c == 't'
      path = File.dirname(fs1[li]) + '/'; break
    end
  end
  pre = nil

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
  elsif c == '@' || c == '['
    hi << fi; fi = hi[0] || ''; hi.uniq!.rotate!; hishow = true
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
  elsif c == "\e[3~" || c == 'C' # Delete
    fi = ''; li = 0
  elsif c.length > 1
    p c; sleep 0.7
  elsif c == ' '
    li1 = li + 1
    #while li1 < fs1.length
    loop do
      if li1 >= fs1.length
        li = 0; break
      end
      f = fs1[li1]
      d = detail(f)
      if d && (d[:diff] || d[:recent])
        li = li1; break
      end
      li1 += 1
    end
  elsif c == ':' || c == ';'
    pre = c
  elsif ';'.index(c)
    # ignore
  else
    fi = fi + c.downcase; li = 0
  end

#rescue => err
#  p err
end

print "[2J" # clear

hi = ([ fi ] + hi).take(7).uniq.join('|')

File.open(ARGV[0], 'wb') { |f| f.puts([ path, hi, li.to_s ].join("\n")) }

