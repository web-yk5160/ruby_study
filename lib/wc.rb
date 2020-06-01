# frozen_string_literal: true

require 'optparse'

class Wc
  def initialize
    @options = {}
    @count = 0
    @line_total = 0
    @words_total = 0
    @byte_num_total = 0
  end

  def parse_options
    opt = OptionParser.new
    opt.on('-l', '--lines') { |v| @options[:l] = v }
    opt.parse!(ARGV)
  end

  def sum
    @line_total += @line
    @words_total += @words
    @byte_num_total += @byte_num
    @count += 1
  end

  def open_files
    ARGV.each do |arg|
      file = File.open(arg)
      content = file.read
      @line = content.scan(/(\r\n|\r|\n)/).size
      @words = content.bytes { |b| '0x' + b.to_s(16) + ' ' }.lines.map { |l| l.split(/\p{blank}+/).select { |w| w =~ /\S/ }.size }.reduce(:+)
      file.close
      @byte_num = File.size(arg)
      puts @line.to_s.rjust(8) + ' ' + @words.to_s.rjust(7) + ' ' + @byte_num.to_s.rjust(7) + ' ' + arg.to_s.rjust(3) + ' '
      sum
    end
  end

  def no_option
    if File.pipe?(STDIN) || File.select([STDIN], [], [], 0) != nil
      gs = Wc::Input.new
      gs.std_option
    else
      open_files
      puts @line_total.to_s.rjust(8) + ' ' + @words_total.to_s.rjust(7) + ' ' + @byte_num_total.to_s.rjust(7) + ' ' + 'total' if @count >= 2
    end
  end

  def wc_l
    ARGV.each do |arg|
      file = File.open(arg)
      content = file.read
      @line = content.scan(/(\r\n|\r|\n)/).size
      puts @line.to_s.rjust(8) + ' ' + arg.to_s.rjust(3) + ' '
      @line_total += @line
      @count += 1
    end
    puts @line_total.to_s.rjust(8) + ' ' + 'total' if @count >= 2
  end

  def select_option
    parse_options
    if @options[:l]
      wc_l
    else
      no_option
    end
  end
end

class Wc::Input
  def initialize
    @count = 0
    @txt = []
    @bytes = []
  end

  def display
    byte = @bytes.flatten.map(&:to_i).sum
    @results.flatten!.to_s.bytesize
    size = @results.size
    puts @count.to_s.rjust(8) + ' ' + size.to_s.rjust(7) + ' ' + byte.to_s.rjust(7) + ' '
  end

  def std_option
    $stdin.each do |arg|
      bytesize = arg.bytesize.to_s.split
      @bytes.push(bytesize)
      some = arg.split(' ')
      @results = @txt.push(some)
      @count += 1
    end
    display
  end
end

wc = Wc.new
wc.select_option
