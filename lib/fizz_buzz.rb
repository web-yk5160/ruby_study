def fizz_buzz(n)
  if n % 15 == 0
    'Fizz Buzz'
  elsif n % 3 == 0
    'Fizz'
  elsif n % 5 == 0
    'Buzz'
  else
    n.to_s
  end
end




# # %q!はシングルクオートで囲んだことと同じ
# puts %q!He said, "Dont speak."!
# # %Q!はダブルクオートで囲んだことと同じ
# something = "Hello!"
# puts %Q!He said, "#{something}"!
# # %!はダブルクオートで囲んだことと同じ
# something = "Bye"
# puts %!He said, "#{something}"!
# # ?を区切り文字として使う
# puts %q?He said, "Dont speak."?
# # {}を区切り文字として使う
# puts %q{He said, "Dont speak."}


# a = <<TEXT
# これはヒアドキュメントです。
# 複数行に渡る長い文字列を作成するのに便利です。
# TEXT
# puts a


# def some_method
#   <<-TEXT
# これはヒアドキュメントです
# <<を使うと最後の識別子をインデントさせることができます。
#   TEXT
# end

# puts some_method

# # ヒアドキュメントを直接引数として渡す(prependは渡された文字列を先頭に追加する)
# a ='Ruby'
# a.prepend(<<TEXT)
# java
# PHP
# TEXT
# puts a

# # ヒアドキュメントで作成した文字列に対して、直接upcaseメソッドを呼び出す
# b = <<TEXT.upcase
# Hello,
# Good-bye.
# TEXT
# puts b

# # 複素数リテラルを使う (0.5iが複素数リテラル)
# c = 0.3 - 0.5i
# c
# c.class

# # Alice Bob Carolの順に検索し、最初に見つかったユーザを変数に格納
# user = find_user('Alice') || find_user('Bob') || find_user('Carol')

# # 正常なユーザであればメールを送信する
# user.valid? && send_mail_to(user)



# def foo(time = Time.now, message = bar)
#   puts "time: #{time}, message: #{message}"
# end

# def bar
#   'Bar'
# end

# foo


# # upcaseだと変数aの値は変化しない
# a = 'ruby'
# a.upcase
# a

# # upcase!だとaの値も大文字に変化
# a.upcase!
# a


# a = 'hello'
# b = 'hello'
# c = d

# # 渡された文字列を破壊的に大文字に変換するメソッドを定義
# def m!(d)
#   d.upcase!
# end

# # cにm!メソッドを適用
# m!(c)

# # b、cはいずれも大文字になる
# b
# c






# a = [1, 2, 3, 1, 2, 3]
# a.delete_if do |n|
#   n.odd?
# end
#
# puts a

# 4.3.5↓

# numbers = [1,2,3,4]
# sum = 0
# # ブロックをあえて改行せずに書く
# numbers.each do |n| sum += n end
# puts sum
#
# numbers = [1,2,3,4]
# sum = 0
# # do...endの代わりに{}を使う
# numbers.each { |n| sum += n }
# puts sum
#
#
#
# numbers = [1,2,3,4]
# sum = 0
# # do...endの代わりに{}を使う
# numbers.each { |n|
#   sum += n
# }
# puts sum


# このコードは
# ['ruby', 'java', 'perl'].map{ |s| s.upcase }
# # こう書き換えられる
# ['ruby', 'java', 'perl'].map(&:upcase)
#
# # このコードは
# [1,2,3,4,5,6].select { |n| n.odd? }
# # こう書き換えられる
# [1,2,3,4,5,6].select(&:odd?)


# def charge(age)
#   case age
#   when 0..5
#     0
#   when 6..12
#     300
#   when 13..18
#     600
#   else
#     1000
#   end
# end

# puts charge(3)
# puts charge(12)
# puts charge(16)
# puts charge(25)
