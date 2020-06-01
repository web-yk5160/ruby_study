require 'optparse'
require "stringio"

class Wc
  def initialize
    @options = {}
  end

  def parse_options
    opt = OptionParser.new
    # 標準入力
    # opt.on(ARGF) { |s| @options[:n] = v }
    opt.on('-l', '--lines') { |v| @options[:l] = v }
    opt.parse!(ARGV)
  end

  def no_option
    count = 0
    ans_sum = 0
    num1_sum = 0
    num2_sum = 0
    file_name = ARGV.each_with_index do |arg, i|
      files = arg
      # file_name = ARGV[0]
      file = File.open(arg)
      content = file.read
      #aの結果の準備
      ans=0
      #b,cの結果の準備

      ans = content.scan(/(\r\n|\r|\n)/).size
      content.bytes { |b| "0x" + b.to_s(16) + " " }
      # p content.unpack("*H")
      # p bytes

      txt = []
      words = content.lines.map { |l| l.split(/\p{blank}+/).select { |w| w =~ /\S/ }.size }.reduce(:+)
      # words = content.lines.map { |l| l.split(/\p{blank}+/)..scan(/(\f|\n|\r|\t|\v)/).size.reduce(:+)
      # content.each_line do |line|
      #   # lineの行で行数を数える
      #     # ans+=1
      #     txt.push(line.split(" "))
      # end
      file.close
      #多次元配列を一次元配列にする(bの処理)
      txt.flatten!

      num1 = txt.size
      #cの処理
      # word = txt.join
      # num2 = word.size
      num2 = File.size(arg)
      # #aの結果
      # puts "このファイルは#{ans}行です"
      # #bの結果
      # puts "このファイルは#{num1}単語です"
      # #cの結果
      # puts "このファイルは#{num2}バイトです"
      puts ans.to_s.rjust(8) + " " + words.to_s.rjust(7) + " " + num2.to_s.rjust(7) + " " + arg.to_s.rjust(3) + " "
      ans_sum+=ans
      num1_sum+=num1
      num2_sum+=num2
      count+=1
    end
    if count >= 2
      puts ans_sum.to_s.rjust(8) + " " + num1_sum.to_s.rjust(7) + " " + num2_sum.to_s.rjust(7) + " " + "total"
    end
  end

  def wc_l
    count = 0
    sum = 0
    file_name = ARGV.each_with_index do |arg, i|
      files = arg
      # file_name = ARGV[0]
      file = File.open(arg)
      content = file.read
      #aの結果の準備
      ans=0
      ans = content.scan(/(\r\n|\r|\n)/).size
      # file.each_line do |line|
        # lineの行で行数を数える
        # ans = file.count("\n")
        # ans+=1 if /[^\n]\z/ =~ file
      # end
      # file.close
      puts ans.to_s.rjust(8) + " " + arg.to_s.rjust(3) + " "
      sum+=ans
      count+=1
    end
    if count >= 2
      puts sum.to_s.rjust(8) + " " + "total"
    end
  end

  def std_option
    puts "aaa"
  end


  def select_option
    parse_options
    if @options[:l]
      wc_l
    elsif @options[:val]
      std_option
    else
      no_option
    end
  end
end

wc = Wc.new
wc.select_option




    # text = "配 列"
    # text.bytes { |b| print "0x" + b.to_s(16) + " " }

    # input = STDIN.gets
    # input


    # open('bank.rb'){|f|
    #   while f.gets; end
    #   p f.lineno
    # }

    # #ファイル名取得
    # p filename = ARGF.filename   #=> text.txt

    # ARGF.each_line do |line|

    #   #ファイル行数
    #   # lineno = ARGF.lineno


    #   puts "#{line}"

    # end

    # input = STDIN
    # p input




    # total = [0]

    # for a in STDIN
    #   b = a.split
    #   for x in 0 ... b.size
    #     if x < total.size
    #       total[x] += b[x].to_i
    #     else
    #       total.push b[x].to_i
    #     end
    #   end
    # end

    # print 'total = '
    # for x in total
    #   print x, " "
    # end



    # STDIN.each.with_index(1) do |line, i|
    #   # puts "#{i}: #{line.chomp}"
    # end



    ans_sum = 0
    num1_sum = 0
    num2_sum = 0
    count = 0
    txt = []
    sum = []
    # st = STDIN.each_byte do |byte|
    #   p byte
    # end
    # ARGF.each_byte.to_a do |arg|
    #   # p arg
    # end
    # ARGF.binmode
    # a = ARGF.read.size

    byte_arr = []
    arr = []
    file_name = ARGF.each_with_index do |arg, i|
      q = arg.bytesize.to_s.split
      byte_arr.push(q)

      s = arg.split
      arr.push(s)
      # p arr.push(b).inject(:+)

      # a = StringIO.new(arg, 'r+')
      # p a
      # a.each_byte{|ch| p ch }

      # sio = StringIO.new(arg, 'r+')
      # p sio.getc


      # p sio.read                 #=> "hoge"
      # p sio.rewind
      # p sio.read(1)              #=> "h"
      # sio.write("OGE")
      # sio.rewind
      # p sio.read                 #=> "hOGE"
      # arr.push(arg)
      # IO.write("testfile", arg)
      # IO.readlines("testfile", chomp: true)
      # a = write(arg)
      # p arg
      # arg.split("\n").map do |s|
      #   p txt.push(s.split("\n"))
      # end
      # file = File.open(arg)
      # content = file.read
      # @ans = content.scan(/(\r\n|\r|\n)/).size
      # int = arg.bytesize
      # readable = File.stat(arg)
      some = arg.split(" ")
      @num1 = txt.push(some)
      # @num2 = File.size(file)

      # file_name = ARGV[0]
      # file = File.open(arg)
      #aの結果の準備
      ans=0
      #b,cの結果の準備
      # txt = []
      # txt.push(arg)

      count += 1
      # file.each_line do |line|
      #   # lineの行で行数を数える
      #     ans+=1
      #   txt.push(line.split("\n"))
      # end
      # file.close
      #多次元配列を一次元配列にする(bの処理)

      # files = file.split(" ")
      # txt.push(files)
      # txt.flatten!
      # txt.size

      # txt.push(file.split("\n"))
      # txt.flatten!
      # num1 = txt.size
      #cの処理
      # word = txt.join
      # num2 = word.size
      # num2 = File.size(arg)
      # #aの結果
      # puts "このファイルは#{ans}行です"
      # #bの結果
      # puts "このファイルは#{num1}単語です"
      # #cの結果
      # puts "このファイルは#{num2}バイトです"
      # puts ans.to_s.rjust(8) + " " + num1.to_s.rjust(7) + " "
      ans_sum+=ans
      # num1_sum+=num1
      # num2_sum+=num2
    end
    byte = byte_arr.flatten.map(&:to_i).sum
    # @file
    f = arr.flatten!
    line = f.size
    @num1
    @num1.flatten!
    @num1.to_s.bytesize
    size = @num1.size
    # txt.push(@files)
    # txt.flatten!
    # p txt.size
    # word = txt.join
    # num2 = word.size
    # num2 = File.size(arg)
    count
    # puts count.to_s.rjust(8) + " " + size.to_s.rjust(7) + " " + byte.to_s.rjust(7) + " "

    # p File.size('/Users/user/ruby-book/lib')



    # require "stringio"
    # sio = StringIO.new("hoge", 'r+')
    # p sio.read                 #=> "hoge"
    # sio.rewind
    # p sio.read(1)              #=> "h"
    # sio.write("OGE")
    # sio.rewind
    # p sio.read                 #=> "hOGE"












# 下記からディレクトリの"d"とfileの"-"の修正箇所
# def l_options(files, stats)
#   files = Dir.glob('*').sort
#   nlink = stats.map(&:nlink)
#   uid = stats.map(&:uid)
#   user_id = uid.map { |u| u == 501 ? 'user' : u }
#   gid = stats.map(&:gid)
#   group_id = gid.map { |g| g == 20 ? 'staff' : g }
#   size = stats.map(&:size)
#   mtime = stats.map(&:mtime)
#   times = mtime.map { |time| time.strftime("%-m %-d %H:%M") }
#   blocks = stats.map(&:blocks)
#   mode = stats.map { |stat| "%o" % stat.mode }
#   total = blocks.sum
#   puts "total #{total}"

#   # type = get_ftype(files)
#   # p type
#   # type.chars.map{|t| t.to_i}

#   # files.each do |item|
#   #   if File::ftype(item) == "file"
#   #     @type = "-"
#   #   elsif File::ftype(item) == "directory"
#   #     @type = "d"
#   #   else File::ftype(item) == "link"
#   #     @type = "l"
#   #   end
#   # end


#   # file_mode = mode.map do |m|
#     # @file_mode = []
#     # mode.zip(files).each do |m, item|
#       # if FileTest.directory?(item)
#       #   a = m[-3, 3].chars.map{|n| n.to_i} #=> [6, 4, 4]
#       #   perm = { 7 => 'rwx', 6 => 'rw-', 5 => 'r-x', 4 => 'r--', 3 => '-wx', 2 => '-w-', 1 => '--x', 0 => '---' }
#       #   @file_mode = "d" + perm[a[0]] + perm[a[1]] + perm[a[2]]
#       # elsif FileTest.file?(item)
#       #   a = m[-3, 3].chars.map{|n| n.to_i} #=> [6, 4, 4]
#       #   perm = { 7 => 'rwx', 6 => 'rw-', 5 => 'r-x', 4 => 'r--', 3 => '-wx', 2 => '-w-', 1 => '--x', 0 => '---' }
#       #   @file_mode = "-" + perm[a[0]] + perm[a[1]] + perm[a[2]]
#       # else
#       #   raise 'ファイルでもディレクトリでもない'
#       # end

#       a = m[-3, 3].chars.map{|n| n.to_i}
#       perm = { 7 => 'rwx', 6 => 'rw-', 5 => 'r-x', 4 => 'r--', 3 => '-wx', 2 => '-w-', 1 => '--x', 0 => '---' }


#       FileTest.directory?(item) == "directory" ? @file_mode.push("d" + perm[a[0]] + perm[a[1]] + perm[a[2]]) : @file_mode.push("-" + perm[a[0]] + perm[a[1]] + perm[a[2]])



#       # perm.each { |key, value|
#       #   # p key + key + key
#       #   arr.push(key)
#       #   # p perm[7]
#       #   # puts (value)
#       # }

#       # p perm[7]
#       # if m == '100644'
#       #   '-rw-r--r--'
#       # elsif m == '40755'
#       #   '-rwxr-xr-x'
#       # elsif m == '40700'
#       #   '-rwxr-----'
#       # elsif m == '100400'
#       #   '-r--------'
#       # elsif m == '40775'
#       #   '-rwxrwxr-x'
#       # elsif m == '100755'
#       #   '-rwxr-xr-x'
#       # end
#     end

#     l_option = [@file_mode, nlink, user_id, group_id, size, times, files].transpose

#     l_option.each_with_index do |_n, i|
#       puts l_option[i].join(' ')
#     end
# end





# def get_ftype(files)
#   files = Dir.glob('*').sort

#   type = files.each do |item|
#     type = ""
#     case File::ftype(item)
#     when "file"
#       type = "-"
#     when "directory"
#       type = "d"
#     when "link"
#       type = "l"
#     else
#     end
#   end
#   type
# end