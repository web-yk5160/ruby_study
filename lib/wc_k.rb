# frozen_string_literal: true

require "thor"

class WC < Thor
  desc "wc command", "wc [file]"
  option :l, type: :boolean

  def wc(file_path = nil)
    text = WCString.new(file_path)
    display =
      if options[:l]
        "#{text.wc_lines}"
      else
        "#{text.wc_lines} #{text.wc_words} #{text.wc_size} #{text.origin_file}"
      end
    puts display
  end
end

class WCString
  attr_reader :origin_file

  def initialize(file_path)
    @text = file_path ? File.read(file_path) : $stdin.read
    @origin_file = file_path
  end

  def wc_lines
    @text.count("\n").to_s.rjust(8)
  end

  def wc_words
    @text.scan(/\S+/).size.to_s.rjust(7)
  end

  def wc_size
    @text.size.to_s.rjust(7)
  end
end

WC.start(ARGV)