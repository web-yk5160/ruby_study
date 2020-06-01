# frozen_string_literal: true

require 'optparse'

class LsCommand
  def initialize
    @options = {}
  end

  def parse_options
    opt = OptionParser.new
    opt.on('-a', '--all') { |v| @options[:a] = v }
    opt.on('-l') { |v| @options[:l] = v }
    opt.on('-r', '--reverse') { |v| @options[:r] = v }
    opt.parse!(ARGV)
  end

  def no_option
    files = Dir.glob('*').sort
    string_length(files)
  end

  def ls_a
    files = Dir.glob('*', File::FNM_DOTMATCH).sort
    string_length(files)
  end

  def ls_l
    files = Dir.glob('*').sort
    stats = Dir.glob('*').sort.map! { |file| File.stat(file) }
    l_options(files, stats)
  end

  def ls_r
    files = Dir.glob('*').sort.reverse
    string_length(files)
  end

  def string_length(files)
    str_length_max = 0
    files.each { |n| str_length_max <= n.length ? str_length_max = n.length : n.length }
    column = `tput cols`.to_i / (str_length_max + 1)
    files.each_with_index do |item, index|
      print "%-#{str_length_max}s " % [item]
      case (index + 1) % column
      when 0
        print "\n"
      end unless index.zero?
    end
  end

  def ls_type
    hash = { "d": "directory", "-": "file", "l": "link" }
    # dir = Dir.glob('*')
    filetype = hash.key(dir)
  end

  def permission(mode)
    mode.map do |m|
      tail = m[-3, 3].chars.map(&:to_i)
      perm = {
        7 => 'rwx', 6 => 'rw-', 5 => 'r-x', 4 => 'r--', 3 => '-wx',
        2 => '-w-', 1 => '--x', 0 => '---'
      }
      "-" + perm[tail[0]] + perm[tail[1]] + perm[tail[2]]
    end
  end

  def file_stat(stats)
    @nlink = stats.map(&:nlink)
    @user_id = stats.map(&:uid).map { |u| u == 501 ? 'user' : u }
    @group_id = stats.map(&:gid).map { |g| g == 20 ? 'staff' : g }
    @size = stats.map(&:size)
    @times = stats.map(&:mtime).map { |time| time.strftime('%-m %-d %H:%M') }
    @mode = stats.map { |stat| '%o' % stat.mode }
    blocks = stats.map(&:blocks)
    puts "total #{blocks.sum}"
  end

  def l_options(files, stats)
    file_stat(stats)
    l_option = [permission(@mode), ls_nlink, ls_user_id, ls_group_id, ls_size, ls_date(stats), ls_time(stats), files].transpose

    l_option.each_with_index do |n, i|
      puts "#{n[0]}   " +
      "#{n[1]} #{n[2]} #{n[3]}  #{n[4].to_s.rjust(max_digit(:size))} " +
      "#{n[5].to_s.rjust(2)} #{n[6].to_s.rjust(2)} #{n[7]}\n"
    end
  end

  def ls_alr
    files = Dir.glob('*', File::FNM_DOTMATCH).sort.reverse
    stats = Dir.glob('*', File::FNM_DOTMATCH).sort.reverse.map! { |file| File.stat(file) }
    l_options(files, stats)
  end

  def ls_nlink
    @nlink
  end

  def ls_user_id
    @user_id
  end

  def ls_group_id
    @group_id
  end

  def ls_size
    @size
  end

  def ls_date(stats)
    t = stats.map(&:mtime).map { |time| time.strftime('%m %d') }
    # "#{t.strftime('%-m').rjust(2)} #{t.strftime('%-d').rjust(2)}"
  end

  def ls_time(stats)
    t = stats.map(&:mtime).map { |time| time.strftime('%H:%M') }
    # t.year == Time.now.year ? t.strftime("%H:%M") : t.strftime(" %-Y")
  end

  def max_digit(object)
    case object
    when :nlink
      @nlink.max.to_s.length
    when :user_id
      @user_id.max.length
    when :group_id
      @group_id.max.length
    when :size
      @size.max.to_s.length
    end
  end

  def select_option
    parse_options
    case @options
    when { a: true, l: true, r: true }
      ls_alr
    when { a: true }
      ls_a
    when { r: true }
      ls_r
    when { l: true }
      ls_l
    else
      no_option
    end
  end
end

ls = LsCommand.new
ls.select_option
