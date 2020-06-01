# frozen_string_literal: true

require "thor"
require "etc"

class LS < Thor
  desc "ls command", "ls command and -a, -l, -r, option"
  option :a, type: :boolean
  option :l, type: :boolean
  option :r, type: :boolean

  def ls
    filenames = (options[:a] ? Dir.glob("*", File::FNM_DOTMATCH) : Dir.glob("*")).sort
    if options[:r] then filenames.reverse! end

    files = Files.new(filenames.map { |file| FileInfo.new(file) })

    display =
      if options[:l]
        total = "total #{files.total_block}\n"
        files.inject(total) do |result, file|
          result + "#{file.ls_type}#{file.ls_permission}   " +
          "#{file.ls_hardlink} #{file.ls_owner} #{file.ls_group}  #{file.ls_size} " +
          "#{file.ls_date} #{file.ls_time_or_year} #{file.ls_name}\n"
        end
      else
        files.names.join("\n")
      end

    puts display
  end
end

class Files < Array
  def initialize(*args)
    super(*args)
    self.each { |file| file.origin = self }
  end

  def total_block
    self.inject(0) { |result, file| result + file.block }
  end

  def names
    self.map { |f| f.name }
  end

  def hardlinks
    self.map { |f| f.hardlink }
  end

  def owners
    self.map { |f| f.owner }
  end

  def groups
    self.map { |f| f.group }
  end

  def sizes
    self.map { |f| f.size }
  end

  def max_digit(object)
    case object
    when :hardlink
      hardlinks.max.to_s.length
    when :owner
      owners.max.length
    when :group
      groups.max.length
    when :size
      sizes.max.to_s.length
    end
  end
end

class FileInfo
  attr_accessor :origin
  attr_reader :block, :type, :permission, :hardlink, :owner, :group, :size, :time, :name, :synlink_name

  def initialize(file)
    read(file) if File.exist?(file)
  end

  def read(file)
    fs = File.lstat(file)
    @block = fs.blocks
    @type = File.ftype(file)
    @permission = fs.mode.to_s(2)[-9, 9]
    @hardlink = fs.nlink
    @owner = Etc.getpwuid(fs.uid).name
    @group = Etc.getgrgid(fs.gid).name
    @size = fs.size
    @time = fs.mtime
    @name = File.basename(file)
    @synlink_name = File.readlink(file) if @type == "link"
    self
  end

  def ls_type
    hash = { "d": "directory", "-": "file", "l": "link" }
    filetype = hash.key(type)
  end

  def ls_permission
    full_permission = "rwx"
    binary_permission = permission.chars.map(&:to_i)
    binary_permission.map.with_index { |p, i| p == 0 ? "-" : full_permission[i % 3] }.join
  end

  def ls_hardlink
    hardlink.to_s.rjust(origin.max_digit(:hardlink))
  end

  def ls_owner
    p owner.to_s.rjust(origin.max_digit(:owner)).class
  end

  def ls_group
    group.to_s.rjust(origin.max_digit(:group))
  end

  def ls_size
    size.to_s.rjust(origin.max_digit(:size))
  end

  def ls_date
    t = time
    "#{t.strftime('%-m').rjust(2)} #{t.strftime('%-d').rjust(2)}"
  end

  def ls_time_or_year
    t = time
    t.year == Time.now.year ? t.strftime("%H:%M") : t.strftime(" %-Y")
  end

  def ls_name
    synlink_name ? "#{name} -> #{synlink_name}" : name
  end
end

LS.start(ARGV)