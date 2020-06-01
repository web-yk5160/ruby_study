require 'etc'

class DispDirFiles

  attr_accessor :current_dir, :fname_list, :l_emelemt_num

  def initialize
    @current_dir = "./"
    @fname_list = @current_dir + "test.txt"
    @l_emelemt_num = 9  # -lした時のカラム数
  end

  def main
    arr_dir_file   = get_dir_files # 現在のフォルダ内ファイル取得
    str_valid_argv = get_argv # 引数取得
    arr_dir_file   = check_argv(arr_dir_file, str_valid_argv) # 引数check

    if str_valid_argv.include?("l")
      open_f_l(arr_dir_file, fname_list)
      ex_column_t(fname_list)
    else
      open_f(arr_dir_file, fname_list)
      ex_column(fname_list)
    end

    delete_f(fname_list)
  end

  def get_dir_files
    arr_dir_file = Dir::entries(current_dir).sort
    arr_dir_file = arr_dir_file.select{|f| f unless f[0].include?(".")}
  end

  def get_argv
    arr_argv = ARGV # 引数全部取得
    arr_valid_argv = arr_argv.select{|e| e.include?("-")} # if それぞれの引数の頭に-が付いているか | -がある要素だけピックアップ
    str_valid_argv = arr_valid_argv.map{|e| e.delete("-")}.join # -は消して1つの文字列にする
  end

  def check_argv(arr_dir_file, str_valid_argv)
    if str_valid_argv.include?("a")
      arr_dir_file = opt_a(arr_dir_file, str_valid_argv) # aが入っていたら
    end
    if str_valid_argv.include?("r")
      arr_dir_file = opt_r(arr_dir_file, str_valid_argv)
    end
    if str_valid_argv.include?("l")
      arr_dir_file = opt_l(arr_dir_file, str_valid_argv)
    end
    arr_dir_file
  end

  def opt_a(arr_dir_file, str_valid_argv)
      arr_dir_file = Dir::entries(current_dir).sort # 全取得
  end

  def opt_r(arr_dir_file, str_valid_argv)
      arr_dir_file.sort!.reverse!
  end

  def opt_l(arr_dir_file, str_valid_argv)
      l_list = Array.new
      arr_dir_file.each do |f_name|
        f = File.lstat(current_dir + f_name)

        owner = Etc.getpwuid(File.stat(f_name).uid).name
        group = Etc.getgrgid(File.stat(f_name).gid).name

        month = f.mtime.strftime("%m")
        day   = f.mtime.strftime("%d")
        time  = f.mtime.strftime("%H:%M")

        type      = get_ftype(f_name)
        perm_strs = get_perm_strs(f)

        l_list << (type + perm_strs) << f.nlink << owner << group << f.size << month << day << time << f_name
      end
      arr_dir_file = l_list
  end

  def get_perm_strs(f)

    mode = "%o" % f.mode
    perm = mode[-3, 3] # "644"

    arr_perm    = perm.chars.map{|n| n.to_i} # [6,4,4]
    arr_perm_bi = arr_perm.map{|n| format("%03b", n).to_i} # [110, 100, 100]

    perm_strs = ""
    arr_perm_bi.each do |n|

      # 110
      if n - 100 >= 0
        n -= 100
        perm_strs += "r"
      else
        perm_strs += "-"
      end

      if n - 10 >= 0
        n -= 10
        perm_strs += "w"
      else
        perm_strs += "-"
      end

      if n - 1 >= 0
        perm_strs += "x"
      else
        perm_strs += "-"
      end

    end
    perm_strs
  end

  def get_ftype(f_name)
    type = ""
    case File::ftype(f_name)
    when "file"
      type = "-"
    when "directory"
      type = "d"
    when "link"
      type = "l"
    else
    end
    type
  end

  def open_f(arr_dir_file, fname_list)
    File.open(fname_list, "w") do |file|
      arr_dir_file.each do |f_name|
        file.puts f_name
      end
    end
  end

  def open_f_l(arr_dir_file, fname_list)
    File.open(fname_list, "w") do |file|
      count = 0
      arr_dir_file.each do |f_name|
        file.print f_name.to_s + " "

        count += 1

        if count == l_emelemt_num
          file.puts
          count = 0
        end
      end
    end
  end

  def ex_column(fname_list)
    sh = system("column #{fname_list}") # terminalに ファイル名表示 / shell実行
  end

  def ex_column_t(fname_list)
    sh = system("column -t #{fname_list}")
  end

  def delete_f(fname_list)
    File.delete(fname_list) # ファイル削除
  end

end

d = DispDirFiles.new
d.main
