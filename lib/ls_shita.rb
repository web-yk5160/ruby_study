#! /usr/bin/env ruby

require "etc"
require "optparse"
require "io/console/size"

class Ls
  COLUMNS = %i[mode nlink owner group size mtime name].freeze

  def initialize(argv)
    @file_list = Ls::FileList.new(argv.getopts("alr"))
  end

  def call
    puts @file_list.text
  end
end

class Ls::FileList
  SHORT_TEXT_MINIMUM_SPACE = 3

  def initialize(options)
    @options = options
    files.each { |file| file.column_widths = column_widths }
  end

  def text
    @options["l"] ? long_text : short_text
  end

  private

  def long_text
    [total, *files.map(&:long_text)].join("\n")
  end

  def short_text
    files.map(&:short_text)
        .tap { |a| a.push(*blanks) } # transeposeするので、サイズを調整しておく
        .each_slice(name_count_per_column).to_a
        .transpose
        .map(&:join)
        .join("\n")
  end

  def blanks
    [""] * (name_count_per_column - (files.size % name_count_per_column))
  end

  def total
    "total #{blocks}"
  end

  def blocks
    files.sum(&:blocks)
  end

  def files
    @files ||= paths.map { |path| Ls::File.new(path) }
  end

  def column_widths
    @column_widths ||= Ls::ColumnWidths.new(*Ls::COLUMNS.map(&method(:column_width)))
  end

  def column_width(column)
    files.map { |file| file.word_count(column) }.max
  end

  def paths
    paths = @options["a"] ? Dir.glob("*", ::File::FNM_DOTMATCH) : Dir.glob("*")
    paths.sort!
    paths.reverse! if @options["r"]
    paths
  end

  def name_count_per_row
    @name_count_per_row ||= terminal_width / (column_widths.name + SHORT_TEXT_MINIMUM_SPACE)
  end

  def name_count_per_column
    @name_count_per_column ||= (files.size.to_f / name_count_per_row).ceil
  end

  def terminal_width
    IO.console_size[1]
  end
end

class Ls::File
  attr_accessor :column_widths

  def initialize(path)
    @file = ::File.open(path)
    @stat = @file.stat
  end

  def long_text
    [
      cell(:mode,  :l, 2),
      cell(:nlink, :r, 1),
      cell(:owner, :l, 2),
      cell(:group, :l, 2),
      cell(:size,  :r, 1),
      cell(:mtime, :r, 1),
      cell(:name,  :l, 0)
    ].join
  end

  def short_text
    cell(:name, :l, 2)
  end

  def word_count(column)
    send(column).size
  end

  def blocks
    @stat.blocks
  end

  private

  def name
    @file.path
  end

  def mode
    ftype + user_permission + group_permission + other_permission
  end

  def nlink
    @stat.nlink.to_s
  end

  def cell(column, lr, right_space)
    column_width = column_widths.send(column)
    send(column).send("#{lr}just", column_width) + (" " * right_space)
  end

  def ftype
    case @stat.ftype
    when "file"      then "-"
    when "directory" then "d"
    end
  end

  def user_permission
    octal_to_rwx(mode_octal[-3])
  end

  def group_permission
    octal_to_rwx(mode_octal[-2])
  end

  def other_permission
    octal_to_rwx(mode_octal[-1])
  end

  def mode_octal
    @mode_octal ||= @stat.mode.to_s(8)
  end

  def octal_to_rwx(octal)
    binary = octal.to_i.to_s(2)

    rwx = ""
    rwx << (binary[0] == "1" ? "r" : "-")
    rwx << (binary[1] == "1" ? "w" : "-")
    rwx << (binary[2] == "1" ? "x" : "-")
    rwx
  end

  def owner
    Etc.getpwuid(@stat.uid).name
  end

  def group
    Etc.getgrgid(@stat.gid).name
  end

  def size
    @file.size.to_s
  end

  def mtime
    "%2d %2d %02d:%02d" % @stat.mtime.instance_eval { |t| [t.month, t.day, t.hour, t.min] }
  end
end

class Ls::ColumnWidths < Struct.new(*Ls::COLUMNS)
end

Ls.new(ARGV).call