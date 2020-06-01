# frozen_string_literal: true

class LsCommand
  require 'optparse'

  def initialize
    @options = {}
  end

  def parse_options
    opt = OptionParser.new
    opt.on('-a', '--all', 'do not ignore entries starting with .') { |v| @options[:a] = v }
    opt.on('-l', 'use a long listing format') { |v| @options[:l] = v }
    opt.on('-r', '--reverse', 'reverse order while sorting') { |v| @options[:r] = v }
    # opt.on('-alr', 'including -a -r, -l options') { |v| @options[:alr] = v }
    opt.on('--help', 'display this help and exit') { |v| puts o; exit }
    opt.parse!(ARGV)
  end

  def no_option
    files = Dir.glob("*").sort

    # 文字数の最大値を算出。
    string_length_max = 0

    files.each do |n|
      if string_length_max <= n.length
        string_length_max = n.length
      end
    end


    # ターミナルの幅 を 文字数の最大値+1 で割ることで、見やすく整形する準備を行う。
    column = (`tput cols`).to_i / (string_length_max + 1)

    # 不要なファイルを配列から削除。
    # without_list = [".", ".."]
    # new_children = children - without_list

    # 実表示部分。
    files.each_with_index do |item, index|
        print "%-#{string_length_max}s " % [item]
        case (index + 1) % column
        when 0
          print "\n"
        end unless index == 0
    end
  end

  def ls_a
    # if @options[:a] == true
    #   Dir.glob("*", File::FNM_DOTMATCH).sort
    # end
    files = Dir.glob("*", File::FNM_DOTMATCH).sort

    # 文字数の最大値を算出。
    string_length_max = 0

    files.each do |n|
      if string_length_max <= n.length
        string_length_max = n.length
      end
    end


    # ターミナルの幅 を 文字数の最大値+1 で割ることで、見やすく整形する準備を行う。
    column = (`tput cols`).to_i / (string_length_max + 1)

    # 不要なファイルを配列から削除。
    # without_list = [".", ".."]
    # new_children = children - without_list

    # 実表示部分。
    files.each_with_index do |item, index|
        print "%-#{string_length_max}s " % [item]
        case (index + 1) % column
        when 0
          print "\n"
        end unless index == 0
    end
  end

  def ls_l
    # if @options[:l] == true
      # target = ARGV[0] || Dir.pwd
      files = Dir.glob('*').sort
      stats = Dir.glob('*').sort.map! { |file| File.stat(file) }
      nlink = stats.map { |stat| stat.nlink }
      uid = stats.map { |stat| stat.uid }
      user_id = uid.map do |u|
        if u == 501
          "user"
        end
      end
      gid = stats.map { |stat| stat.gid }
      group_id = gid.map do |g|
        if g == 20
          "staff"
        end
      end
      size = stats.map { |stat| stat.size}
      mtime = stats.map { |stat| stat.mtime }
      times = mtime.map do |time|
        time.strftime("%-m %-d %H:%M")
      end


      blocks = stats.map { |stat| stat.blocks }
      mode = stats.map { |stat| "%o" % stat.mode}
      # puts block.push(size).push(mode).join(' ')
      # p size.size
      # p mode.size
      # sh = Shell.new
      # sh.ls

      # mode = Dir.glob('*').sort.map! { |file| "%o" % File.stat(file).mode }
      # size = Dir.glob('*').sort.map! { |file| File.stat(file).size }
      # blocks = Dir.glob("*").sort.map! { |file| File.stat(file).blocks }


      # array = []
      # Dir.glob('*') do |d|
      #   array.push(d)
      # end
      # p array


      # puts size

      # stat = Dir.glob('*')
      # stat.each do |s|
      #   puts s.blocks
      # end

      # stat = Pathname.glob("*").sort.map! { |file| File.stat(file) }
      # p stat

      # puts blocks
      # stat.each do |s|
      #   blocks = s.blocks
      #   mode = s.mode
      # end
      # stat = Dir.glob("*").sort
      # p stat


      total = blocks.sum
      puts "total #{total}"


      # blocks.map do |b|
      #   size.map do |s|
          m = mode.map do |m|
            if m == "100644"
              "-rw-r--r--"
            elsif m == "40755"
              "-rwxr-xr-x"
            elsif m == "40700"
              "-rwxr-----"
            elsif m == "100400"
              "-r--------"
            elsif m == "40775"
              "-rwxrwxr-x"
            elsif m == "100755"
              "-rwxr-xr-x"
            end
          end
      #   end
      # end

      # puts m.push(nlink).push(user_id).push(group_id).push(size).push(times).push(files)


      l_option = [
      m,
      nlink,
      user_id,
      group_id,
      size,
      times,
      files
      ].transpose

      l_option.each_with_index do |n, i|
        puts l_option[i].join(' ')
      end



      # text = <<~EOS
      #   にんじん
      #   ブロッコリー
      #   じゃがいも
      # EOS

      # text_list = text.split "\n"

      # example = text_list.map { |text|
      #   (text.concat ' ' * (text_list.map(&:size).max - text.size)).chars
      # }.transpose.map{ |text| text.reverse.join }.join "\n"

      # puts example

      # -rw-r--r--

      #   stat = File.stat(file)
      #   @stat = stat.blocks
      # end

      # puts stat.size # 容量
      # puts "0%o" % stat.mode # パーミッション
      # puts stat.nlink
    # end
  end

  def ls_r
    # if @options[:r] == true
    #   puts Dir.glob("*").sort.reverse
    # end

    files = Dir.glob("*").sort.reverse
    # 文字数の最大値を算出。
    string_length_max = 0

    files.each do |n|
      if string_length_max <= n.length
        string_length_max = n.length
      end
    end


    # ターミナルの幅 を 文字数の最大値+1 で割ることで、見やすく整形する準備を行う。
    column = (`tput cols`).to_i / (string_length_max + 1)

    # 不要なファイルを配列から削除。
    # without_list = [".", ".."]
    # new_children = children - without_list

    # 実表示部分。
    files.each_with_index do |item, index|
        print "%-#{string_length_max}s " % [item]
        case (index + 1) % column
        when 0
          print "\n"
        end unless index == 0
    end
  end

  def ls_ar
    # if @options[:r] == true
    #   puts Dir.glob("*").sort.reverse
    # end

    files = Dir.glob("*", File::FNM_DOTMATCH).sort.reverse
    # 文字数の最大値を算出。
    string_length_max = 0

    files.each do |n|
      if string_length_max <= n.length
        string_length_max = n.length
      end
    end


    # ターミナルの幅 を 文字数の最大値+1 で割ることで、見やすく整形する準備を行う。
    column = (`tput cols`).to_i / (string_length_max + 1)

    # 不要なファイルを配列から削除。
    # without_list = [".", ".."]
    # new_children = children - without_list

    # 実表示部分。
    files.each_with_index do |item, index|
        print "%-#{string_length_max}s " % [item]
        case (index + 1) % column
        when 0
          print "\n"
        end unless index == 0
    end
  end

# -alrでも-lraでも-ralでも順番に関係なく実行できる必要あり
  def ls_alr
    # if @options[:r] == true && if @options[:a] == true && @options[:l] == true
    #   # -a, -l, -rのオプション処理を書く
    # end

    # target = ARGV[0] || Dir.pwd
    files = Dir.glob("*", File::FNM_DOTMATCH).sort.reverse
    stats = Dir.glob("*", File::FNM_DOTMATCH).sort.reverse.map! { |file| File.stat(file) }
    nlink = stats.map { |stat| stat.nlink }
    uid = stats.map { |stat| stat.uid }
    user_id = uid.map do |u|
      if u == 501
        "user"
      end
    end
    gid = stats.map { |stat| stat.gid }
    group_id = gid.map do |g|
      if g == 20
        "staff"
      end
    end
    size = stats.map { |stat| stat.size}
    mtime = stats.map { |stat| stat.mtime }
    times = mtime.map do |time|
      time.strftime("%-m %-d %H:%M")
    end


    blocks = stats.map { |stat| stat.blocks }
    mode = stats.map { |stat| "%o" % stat.mode}
    # puts block.push(size).push(mode).join(' ')
    # p size.size
    # p mode.size
    # sh = Shell.new
    # sh.ls

    # mode = Dir.glob('*').sort.map! { |file| "%o" % File.stat(file).mode }
    # size = Dir.glob('*').sort.map! { |file| File.stat(file).size }
    # blocks = Dir.glob("*").sort.map! { |file| File.stat(file).blocks }


    # array = []
    # Dir.glob('*') do |d|
    #   array.push(d)
    # end
    # p array


    # puts size

    # stat = Dir.glob('*')
    # stat.each do |s|
    #   puts s.blocks
    # end

    # stat = Pathname.glob("*").sort.map! { |file| File.stat(file) }
    # p stat

    # puts blocks
    # stat.each do |s|
    #   blocks = s.blocks
    #   mode = s.mode
    # end
    # stat = Dir.glob("*").sort
    # p stat


    total = blocks.sum
    puts "total #{total}"


    # blocks.map do |b|
    #   size.map do |s|
        m = mode.map do |m|
          if m == "100644"
            "-rw-r--r--"
          elsif m == "40755"
            "-rwxr-xr-x"
          elsif m == "40700"
            "-rwxr-----"
          elsif m == "100400"
            "-r--------"
          elsif m == "40775"
            "-rwxrwxr-x"
          elsif m == "100755"
            "-rwxr-xr-x"
          end
        end
    #   end
    # end

    # puts m.push(nlink).push(user_id).push(group_id).push(size).push(times).push(files)
    l_option = [
    m,
    nlink,
    user_id,
    group_id,
    size,
    times,
    files
    ].transpose

    # # 文字数の最大値を算出。
    # string_length_max = 0

    # files.each do |n|
    #   if string_length_max <= n.length
    #     string_length_max = n.length
    #   end
    # end


    # # ターミナルの幅 を 文字数の最大値+1 で割ることで、見やすく整形する準備を行う。
    # column = (`tput cols`).to_i / (string_length_max + 1)

    l_option.each_with_index do |n, i|
      puts l_option[i].join(' ')
      # l_option[i].each_with_index do |item, index|
      #   print "%#{string_length_max}s " % [item]
      #   case (index + 1) % column
      #   when 0
      #     print "\n"
      #   end unless index == 0
      # end
    end



    # text = <<~EOS
    #   にんじん
    #   ブロッコリー
    #   じゃがいも
    # EOS

    # text_list = text.split "\n"

    # example = text_list.map { |text|
    #   (text.concat ' ' * (text_list.map(&:size).max - text.size)).chars
    # }.transpose.map{ |text| text.reverse.join }.join "\n"

    # puts example

    # -rw-r--r--

    #   stat = File.stat(file)
    #   @stat = stat.blocks
    # end

    # puts stat.size # 容量
    # puts "0%o" % stat.mode # パーミッション
    # puts stat.nlink
  # end
  end

  def print_array_horizon(array)
    # children = Dir::entries(".").sort

    # # 文字数の最大値を算出。
    # string_length_max = 0

    # children.each do |n|
    #   if string_length_max <= n.length
    #     string_length_max = n.length
    #   end
    # end


    # # ターミナルの幅 を 文字数の最大値+1 で割ることで、見やすく整形する準備を行う。
    # column = (`tput cols`).to_i / (string_length_max + 1)

    # # 不要なファイルを配列から削除。
    # without_list = [".", ".."]
    # new_children = children - without_list

    # # 実表示部分。
    # new_children.each_with_index do |item, index|
    #     "%-#{string_length_max}s " % [item]
    #     case (index + 1) % column
    #     when 0
    #       "\n"
    #     end unless index == 0
    # end
    array.each_with_index do |x, index|
      if index == array.size - 1
        # printf("%-20s", x)
        print x
        puts ""
      else
        # printf("%-20s", x)
      end
    end
  end

  def select_option
    parse_options
    if @options[:a] && @options[:r] && @options[:l]
      ls_alr
    elsif @options[:a] && @options[:r]
      ls_ar
    elsif @options[:a]
      ls_a
    elsif @options[:r]
      ls_r
    elsif @options[:l]
      ls_l
    else
      no_option
    end
  end
end

#! /usr/bin/env ruby
#
# ls: 引数なしの場合現在のディレクトリの状態を返す。
#     引数ありの場合そのディレクトリの状態を返す。

# require 'optparse'

# target = ARGV[0] || Dir.pwd

# entries = Dir::entries(target)
# # p entries


# entries.select!{|entry| entry[0] != '.'}

# entries.map! do |entry|
#   if File::directory?(File.join(target, entry))
#     "#{entry}/"
#   else
#     entry
#   end
# end



# puts entries.sort!.join(' ')
# # if `tput lines`.chomp.to_i % 2 == 6
# #   print "\n"
# # end
# # p `tput lines`
# if `tput cols` % 2 == 0
#   print "\n"
# end

ls = LsCommand.new
ls.select_option