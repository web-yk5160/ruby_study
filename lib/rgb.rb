# # # これをリファクタリングすると
# def to_hex(r, g, b)
#   '#' +
#   r.to_s(16).rjust(2, '0') +
#   g.to_s(16).rjust(2, '0') +
#   b.to_s(16).rjust(2, '0') #=> rjustメソッドで"00"にする
# end

# # 繰り返し処理でリファクタリングする
# def to_hex(r, g, b)
#   hex = '#'
#   [r, g, b].each do |n|
#     hex += n.to_s(16).rjust(2, '0')
#   end
#   hex
# end


# injectメソッドでさらにコードを短くリファクタリングできる
def to_hex(r, g, b)
  [r, g, b].inject('#') do |hex, n|
    hex + n.to_s(16).rjust(2, '0')
  end
end

p to_hex(0, 0, 0)

# リファクタリング前
# def to_ints(hex)
#   r = hex[1..2]
#   g = hex[3..4]
#   b = hex[5..6]
#   ints = []
#   [r,g,b].each do |s|
#     ints << s.hex
#   end
#   ints
# end




# リファクタリング後
def to_ints(hex)
  hex.scan(/\w\w/).map(&:hex)
end






# a = [1, 2, 3, 1, 2, 3]
# # 配列から値が奇数の要素を削除する

# a.delete_if do |n|
#   n.odd?
# end
# p a




# numbers = [1, 2, 3, 4]
# sum = 0
# sum_value = 100
# # ブロックの外にもsum_valueはあるが、ブロック内ではブロック引数のsum_valueが優先される
# numbers.each do |sum_value|
#   sum += sum_value
# end
# p sum


# # select
# numbers = [1, 2, 3, 4, 5, 6]
# # ブロックの戻り値が真になった要素だけが集められる
# even_numbers = numbers.select { |n| n.even? }
# p even_numbers



# numbers = [1, 2, 3, 4, 5, 6]
# # 3の倍数を除外する(3の倍数以外を集める)
# non_multiple_of_three = numbers.reject { |n| n % 3 == 0 }
# p non_multiple_of_three


# puts ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].inject('Sun') { |result, s| result + s }


# # ブロックの中でメソッドではなく演算子を使っている
# [1, 2, 3, 4, 5, 6].select { |n| n % 3 == 0 }

# # ブロック内のメソッドで引数を渡している
# [9, 10, 11, 12].map { |n| n.to_s(16) }

# # ブロックの中で複数の文を実行している
# [1, 2, 3, 4].map do |n|
#   m = n * 4
#   m.to_s
# end


# (1...5) #=> 最後の値を含む

# (1..5).class #=> Range
# (1...5).class #=> Range

# range = 1..5
# p range.include?(1) #=> true

# range = 1...5
# p range.include?(5) #=> false





# a = [1, 2, 3, 4, 5]
# # 2番目から4番目の要素を取得する
# a[1..3] #=> [2, 3, 4]


# def liquid?(temperature)
#   (0...100).include?(temperature)
# end

# liquid?(-1) #=> false
# liquid?(0) #=> true
# liquid?(100) #=> false


# numbers = []
# # 1から10まで2つ飛ばしで繰り返し処理を行う
# (1..10).step(2) { |n| numbers << n }
# p numbers #=> [1, 3, 5, 7, 9]






# # values_atメソッドを使うと、取得したい要素の添字を複数指定できる
# a = [1, 2, 3, 4, 5]
# p a.values_at(0, 2, 4)

# a = [1, 2, 3, 4, 5]
# # 最後の要素を取得する
# p a[a.size - 1]
# # 最後から2番目の要素を取得
# p a[-1]
# p a[-2]
# # 最後から2番目の要素から2つ目の要素を取得
# p a[-2, 2]

# # 配列の連結としてconcatと+がある
# a = [1]
# b = [2, 3]
# p a.concat(b)

# # aは変更される(破壊的)
# p a
# # bは変更されない
# p b


# # 配列よりも効率的に集合を扱えるSetクラス
# require 'set'
# a = Set.new([1, 2, 3])
# b = Set.new([3, 4, 5])
# p a | b
# p a - b
# p a & b
# #<Set: {1, 2, 3, 4, 5}>
# #<Set: {1, 2}>
# #<Set: {3}>

# # 多重代入で残りの全要素を配列にする
# e, *f = 100, 200, 300
# p e #=> 100
# p f #=> [200, 300]


# # 1つの配列を複数の引数として展開する
# a = []
# b = [2, 3]
# a. push(1)
# # 配列をそのまま追加する
# p a.push(b) #=> [1, [2, 3]]

# # 配列を展開して複数の引数として渡したい場合はsplat展開として*をおく
# a = []
# b = [2, 3]
# a. push(1)
# # 配列をそのまま追加する
# p a.push(*b) #=> [1, 2, 3]

# # メソッドの可変長引数
# # 引数名の前に*をつける
# def greeting(*name)
#   "#{name.join('と')}、こんにちは!"
# end
# p greeting('田中さん')
# p greeting('田中さん', '鈴木さん')
# p greeting('田中さん', '鈴木さん', '佐藤さん')

# # *で配列同士を非破壊的に連結する
# a = [1, 2, 3]
# p [-1, 0, *a, 4, 5]


# # %記法で文字列の配列を作る
# # %wで文字列の配列を作成する(!で囲む)
# p %w!apple melon orange!
# # %wで文字列の配列を作成する(丸カッコで囲む)
# p %w(apple melon orange)

# # 値にスペースを入れたい場合は、バックスラッシュを使う
# p %w(big\ apple small\ melon orange)

# prefix = 'This is'
# p %W(#{prefix}\ an\ apple small\nmelon orange)




# # 配列に初期値を設定する
# # ブロックを使ってブロックの戻り値を初期値とする
# a = Array.new(5) { 'default' }

# # 1番目の要素を取得する
# str = a[0]
# str

# str.upcase!
# str

# # 1番目の要素だけが大文字になり、他は変わらない
# p a




# fruits = ["apple", "melon", "orange"]
# # ブロック引数のおiには0,1,2...と要素の添字が入る
# p fruits.each_with_index { |fruit, i| puts "#{i}: #{fruit}"}


# fruits = ["apple", "melon", "orange"]
# # ブロック引数のおiには0,1,2...と要素の添字が入る
# p fruits.map.with_index { |fruit, i| puts "#{i}: #{fruit}"}

# fruits = ["apple", "melon", "orange"]
# # ブロック引数のおiには0,1,2...と要素の添字が入る
# p fruits.delete_if.with_index { |fruit, i| fruit.include?('a') && i.odd? }
# p fruits.map
# #=>#<Enumerator: ["apple", "melon", "orange"]:map>



# fruits = ['apple', 'orange', 'melon']

# # eachで繰り返しつつ、1から始まる添字を取得する
# p fruits.each.with_index(1) { |fruit, i| puts "#{i}: #{fruit}" }
# #=> 1: apple
# # 2: orange
# # 3: melon
# p fruits.map.with_index(10) { |fruit, i| "#{i}: #{fruit}" }
# #=> ["10: apple", "11: orange", "12: melon"]



# dimentions = [
#   # [縦, 横]
#   [10, 20],
#   [30, 40],
#   [50, 60]
# ]
# # 面積の計算結果を格納する配列
# areas = []
# # 配列の要素分だけブロック引数を用意すると、各要素の値が別々の変数に格納される
# dimentions.each do |length, width|
#   areas << length * width
# end
# p areas #=> [200, 1200, 3000]




# dimentions = [
#   # [縦, 横]
#   [10, 20],
#   [30, 40],
#   [50, 60]
# ]
# # ブロック引数を()で囲んで、配列の要素を別々の引数として受け取る
# dimentions.each_with_index do |(length, width), i|
#   # 縦の値、横の値、添字の3つの値を1度にブロック引数で受け取れる
#   puts "length: #{length}, width: #{width}, i: #{i}"
# end


# # # sample.txtを開いて文字列を書き込む(クローズ処理は自動的に行われる)
# # File.open("./sample.txt", "w") do |file|
# #   file.puts("1行目のテキストです。")
# #   file.puts("2行目のテキストです。")
# #   file.puts("3行目のテキストです。")
# # end



# # a = [1, 2, 3]
# # a.delete 100 do
# #   'NG'
# # end

# # a.delete 100 { 'NG' }
# # #=> syntax error, unexpected '{', expecting end-of-input

# # # 引数つきのメソッド呼び出しで{}をブロックとして使う場合は、メソッド引数の()を省略できない
# # a.delete(100) { 'NG' }













# ### ブロックのうしろに別のメソッドを続けて書く
# names = ['田中', '鈴木', '佐藤']
# san_name = names.map { |name| "#{name}さん" }
# p san_name.join('と')
# # ブロックの後ろにjoinを呼び出せる
# p names.map { |name| "#{name}さん" }.join('と')

# # do...endの後ろにjoinを呼び出せる
# # p names.map do |name|
# #   "#{name}さん"
# # end.join('と')

# ### stepメソッド
# # 1から10まで2つずつ値を増やす
# a = []
# 1.step(10, 2) { |n| a << n }
# p a

# # 1から10から1まで2つずつ値を減らす
# a = []
# 10.step(1, -2) { |n| a << n }
# p a


# ### while文
# a = []
# while a.size < 5
#   a << 1
# end
# p a

# # 条件文の後ろにdoをいれる
# a = []
# while a.size < 5 do a << 1 end
# p a

# # 1行で書くならwhile文を後ろにおく
# a = []
# a << 1 while a.size < 5
# p a

# # どんな条件でも1回は実行したい場合は、begin...endで囲む
# a = []

# while false
#   # このコードは常に条件が偽になるので実行されない
#   a << 1
# end
# p a

# # begin...endで囲むとどんな条件でも1回は実行される
# begin
#   a << 1
# end while false
# p a


# ### for文の中で作成された変数はfor文の外では参照できる

# ### loop文
# # 5が出るタイミングまで繰り返し処理を実行
# numbers = [1, 2, 3, 4, 5]
# # loop do
# #   # sampleメソッドでランダムに要素を1つ取得する
# #   n = numbers.sample
# #   puts n
# #   break if n == 5
# # end
# # p n #=> undefined local variable or method `n' for main:Object (NameError)

# while true
#   n = numbers.sample
#   puts n
#   break if n == 5
# end

# p n #=> 5

# ### 繰り返し処理に関するメソッドはEnumerableモジュールに定義されていることが多い

# ### throwとcatchを使った大域脱出
# # orangeと3の組み合わせが出たら繰り返し処理を脱出する
# fruits = ['apple', 'melon', 'orange']
# numbers = [1, 2, 3]
# catch :done do
#   fruits.shuffle.each do |fruit|
#     numbers.shuffle.each do |n|
#       puts "#{fruit}, #{n}"
#       if fruit == 'orange' && n == 3
#         # すべての繰り返し処理を脱出する
#         throw :done
#       end
#     end
#   end
# end


# ### 繰り返し処理でのreturnとbreakの違い
# # * returnを使う場合は、(繰り返し処理のみならず)メソッドからの脱出
# # * breakは繰り返し処理からの脱出
# # * 用途に応じて適切に使い分ける

# ### next
# # 偶数であれば、処理を中断して次の繰り返し処理に進む
# fruits = ['apple', 'melon', 'orange']
# numbers = [1, 2, 3, 4]
# fruits.each do |fruit|
#   numbers.each do |n|
#     next if n.even?
#     puts "#{fruit}, #{n}"
#   end
# end


# ### redo
# # 繰り返し処理をやり直したい場合に使用
# # やり直しの回数を制限しないと無限ループになる可能性がある
# foods = ['ピーマン', 'トマト', 'セロリ']
# # やり直しの回数を制限する
# count = 0
# foods.each do |food|
#   print "#{food}は好きですか? => "
#   # sample配列から1要素を取得するメソッド
#   answer = 'いいえ'
#   puts answer

#   count += 1
#   # やり直しは2回までにする
#   redo if answer != 'はい' && count < 2

#   # カウントをリセット
#   count = 0
# end


# ## ハッシュ
# ### ハッシュは内部構造上、キーと値が大量に格納されている場合でも、指定したキーに対応する値を高速に取り出せるのが特徴


# ### 同値比較
# # 並び順が異なっていてもキーと値が全て同じならtrue
# a = { 'x' => 1, 'y' => 2, 'z' => 3 }
# c = { 'z' => 3, 'y' => 2, 'x' => 1 }
# p a == c


# ### 要素の削除
# currencies = {'japan' => 'yen', 'us' => 'dollar', 'india' => 'rupee' }
# currencies.delete('japan')
# p currencies

# ### :apple.methods
# # シンボルのメソッド名
# # => [:start_with?, :end_with?, :<=>, :to_sym, :to_proc, :==, :to_s, :===, :=~, :next, :[], :casecmp, :casecmp?, :match, :match?, :empty?, :slice, :encoding, :upcase, :inspect, :intern, :capitalize, :downcase, :swapcase, :length, :id2name, :size, :succ, :clamp, :between?, :<=, :>=, :>, :<, :dup, :itself, :yield_self, :then, :taint, :tainted?, :untaint, :untrust, :untrusted?, :trust, :frozen?, :methods, :singleton_methods, :protected_methods, :private_methods, :public_methods, :instance_variables, :instance_variable_get, :instance_variable_set, :instance_variable_defined?, :remove_instance_variable, :instance_of?, :kind_of?, :is_a?, :tap, :singleton_class, :clone, :display, :hash, :class, :method, :public_method, :public_send, :singleton_method, :define_singleton_method, :extend, :to_enum, :enum_for, :!~, :nil?, :eql?, :respond_to?, :freeze, :object_id, :send, :__send__, :!, :__id__, :!=, :equal?, :instance_eval, :instance_exec]

# ### 異なるデータ型が混在するケース
# person = {
#   # 値が文字列
#   name: 'Alice',
#   # 値が数値
#   age: 20,
#   # 値が配列
#   friends: ['Bob', 'Carol'],
#   # 値がハッシュ
#   phones: { home: '1234-0000', mobile: '5678-0000' }
# }

# p person[:age]
# p person[:friends]
# p person[:phones][:mobile]



# ### メソッドのキーワード引数とハッシュ
# # def buy_burger(menu, drink, potato)
# #   # ハンバーガを購入
# #   if drink
# #     # ドリンクを購入
# #   end
# #   if potato
# #     # ポテトを購入
# #   end
# # end

# # フィッシュバーガとドリンクを購入する
# # 2つ目と2つ目の引数が何を表しているのかわかりづらい

# # # キーワード引数を使わない場合
# # buy_burger('fish', true, false)
# # # キーワード引数を使う場合
# # buy_burger('fish', drink: true, potato: true)

# # キーワード引数と一致するハッシュがあれば、メソッドの引数として渡せる
# # params = { drink: true, potato: true }
# # buy_burger('fish', params)


# ### キーや値に異なるデータ型を混在させる
# # 文字列とハッシュのキーを混在させる
# hash = { 'abc' => 123, def: 456 }
# # 値を取得する場合はデータ型を合わせてキーを指定する
# hash['abc']
# hash[:def]



# ### **でハッシュを展開させる
# h = { us: 'dollar', india: 'rupee' }
# # 変数hのキーと値を**で展開させる
# { japan: 'yen', **h }
# #=> {:japan=>"yen", :us=>"dollar", :india=>"rupee"}

# h = { us: 'dollar', india: 'rupee' }
# #mergeメソッドでも同じ結果を得られる
# { japan: 'yen' }.merge(h)
# #=> {:japan=>"yen", :us=>"dollar", :india=>"rupee"}

# ### ハッシュを使った擬似キーワード引数
# def buy_burger(menu, option = {})
#   drink = option[:drink]
#   potato = option[:potato]
# end

# buy_burger('cheese', drink: true, potato: true)


# ### 任意のキーワードを受け付ける**引数
# def buy_burger(menu, drink: true, potato: true, **others)
#   # othersはhashとして渡される
#   puts others
# end
# buy_burger('fish', drink: true, potato: false, salad: true, chicken: false)
# #=> {:salad=>true, :chicken=>false}

# ### ハッシュの{}とブロックの{}
# # ()なしのメソッド呼び出し
# def buy_burger(options = {}, menu)
#   # othersはhashとして渡される
#   puts options
# end
# # 第1引数にハッシュの{}が来る場合は()を省略できない
# # buy_burger{'drink' => true, 'potato' => false}, 'fish'
# buy_burger({'drink' => true, 'potato' => false}, 'fish')
# # => {"drink"=>true, "potato"=>false}

# # 第2引数にハッシュが来る場合は()を省略できる
# def buy_burger(menu, options = {})
#   # othersはhashとして渡される
#   puts options
# end
# buy_burger 'fish', {'drink' => true, 'potato' => false}
# # => {"drink"=>true, "potato"=>false}


# currencies = {'japan' => 'yen', 'us' => 'dollar', 'india' => 'rupee' }
# # to_aメソッドでキーと値が1つの配列になる
# p currencies.to_a

# array = [["japan", "yen"], ["us", "dollar"], ["india", "rupee"]]
# p array.to_h
# # =>{"japan"=>"yen", "us"=>"dollar", "india"=>"rupee"}

# # Hash[]に対して配列を渡す
# p Hash[array]
# # =>{"japan"=>"yen", "us"=>"dollar", "india"=>"rupee"}
# # キーと値が交互に並ぶフラットな配列をsplat展開
# array = ["japan", "yen", "us", "dollar", "india", "rupee"]
# p Hash[*array]


# ### シンボルの配列を作成する%iと%I
# # %iでは改行文字や式展開の構文が、そのままシンボルになる
# p %i(hello\ngood-bye ${name.upcase})
# # ％Iでは改行文字や式展開が有効になった上でシンボルが作られる
# p %I(hello\ngood-bye ${name.upcase})

# # 国名に応じて通過を返す
# def find_currency(country)
#   currencies = { japan: 'yen', us: 'dollar', india: 'rupee' }
#   currencies[country]
# end

# # 指定された国の通過を大文字にして返す
# def show_currency(country)
#   currency = find_currency(country)
#   # nilでないことをチェック
#   if currency
#     currency.upcase
#   end
# end
# # 通過が見つかる場合と見つからない場合の結果を確認
# p show_currency(:japan) # =>"YEN"
# p show_currency(:brazil) # nil

# ### &.演算子
# # &.演算子はnilかもしれないメソッドを呼び出すときに使用
# # nilでない場合はその結果、nilの場合はnilを返す
# # show_currencyメソッドを&.演算子を使って書き換える
# def show_currency(country)
#   currency = find_currency(country)
#   # nilでないことをチェック
#   currency&.upcase
# end

# p show_currency(:japan) # =>"YEN"
# p show_currency(:brazil) # nil

# # X ||= A
# # 変数がnilまたはfalseなら、AをXに代入と考える
# limit = nil
# limit ||= 10
# p limit

# limit = 20
# limit ||= 10
# p limit



# ## 正規表現

# text = <<TEXT
# I love Ruby.
# Python is great language
# Java and JavaScript are different.
# TEXT
# p text.scan(/[A-Z][A-Za-z]+/)
# #=> ["Ruby", "Python", "Java", "JavaScript"]


# text = <<TEXT
# 私の郵便番号は1234567です
# 僕の住所は6770056 兵庫県西脇市板並張1234だよ
# TEXT

# puts text.gsub(/(\d{3})(\d{4})/, '\1-\2')

# ### キャプチャの結果に名前をつける
# # キャプチャには(?<name>)というメタ文字で名前を付けられる
# text = '私の誕生日は1977年7月17日です。'
# # キャプチャの名前がそのままローカル変数に割り当てる
# if /(?<year>\d+)年(?<month>\d+)月(?<day>\d+)日/ =~ text
#   puts "#{year}/#{month}/#{day}"
# end


# ### 正規表現と組み合わせると便利なStringクラスのメソッド
# ### slice
# text = '誕生日は1977年7月17日です'
# # 第2引数を指定して3番目のキャプチャを取得する
# p text.slice(/(\d+)年(\d+)月(\d+)日/, 3)
# # =>"17"

# ### slice!で破壊的に取り除く
# text = '郵便番号は123-4567です'
# p text.slice!(/\d{3}-\d{4}/)
# # =>"123-4567"
# p text #=>"郵便番号はです"



# ### split
# text = '123,456-789'

# # 正規表現を使ってカンマまたはハイフンを区切り文字に指定する
# p text.split(/,|-/)

# # 正規表現でマッチした部分を第2引数で置き換える
# p text.gsub(/,|-/, ':')




# ### 正規表現オブジェクトを作成する方法
# # /\d{3}-\d{4}/と同じ
# Regexp.new('\d{3}-\d{4}')

# ### %記法
# # スラッシュを囲むと、スラッシュをエスケープする必要がある
# /http:\/\/example\.com/

# # %rを使うとスラッシュをエスケープしなくて良い
# %r!http://example\.com!

# # !でなく{}を区切り文字にする
# %r{http://example\.com}

# # / /や%rのなかで#{}を使うと変数の中身を展開できる
# pattern = '\d{3}-\d{4}'
# # 変数が展開されるので/\d{3}-\d{4}/と書いたことと同じ
# p '123-4567' =~ /#{pattern}/


# ### 正規表現作成時のオプション
# # iオプションをつけると大文字小文字を区別しない
# p 'HELLO' =~ /hello/i

# # %rを使った最後にオプションを付けられる
# p 'HELLO' =~ %r{hello}i

# # Regexp.newを使う場合は、Regexp::IGNORECASEという定数を使用
# regexp = Regexp.new('hello', Regexp::IGNORECASE)
# p 'HELLO' =~ regexp


# ### mオプション
# # .が改行文字にもマッチする
# p "Hello\nBye" =~ /Hello.Bye/m

# # Regexp.newを使う場合は、Regexp::MULTILINEという定数を使用
# regexp = Regexp.new('Hello.Bye', Regexp::MULTILINE)
# p "Hello\nBye" =~ regexp

# ### xオプション
# # xオプションを付けたので改行やスペースが無視され、コメントも書ける
# regexp = /
#   \d{3} # 郵便番号の先頭3桁
#   -     # 区切り文字のハイフン
#   \d{4} # 郵便番号の末尾4桁
# /x
# p '123-4567' =~ regexp

# # 空白を無視せず正規表現の一部として扱いたい場合はバックスラッシュでエスケープする
# regexp = /
#   \d{3}
#   \ # 半角スペースで区切る
#   \d{4}
# /x
# p '123 4567' =~ regexp


# # Regexp.newを使う場合は、Regexp::EXTENDEDという定数を使用
# pattern = <<'TEXT'
#   \d{3} # 郵便番号の先頭3桁
#   -     # 区切り文字のハイフン
#   \d{4} # 郵便番号の末尾4桁
# TEXT
# regexp = Regexp.new(pattern, Regexp::EXTENDED)
# '123-4567' =~ regexp

# # iオプションとmオプションを同時に使う
# p "HELLO\nBYE" =~ /Hello.Bye/im

# # Regexp.newを使う場合は|で連結
# regexp = Regexp.new('Hello.Bye', Regexp::IGNORECASE | Regexp::MULTILINE)
# p "Hello\nBye" =~ regexp

# ### Regexp.last_matchでマッチの結果を取得する
# text = '私の誕生日は1977年7月17日です。'
# # =~演算子などを使うと、マッチした結果をRegexp.last_matchで取得できる
# text =~ /(\d+)年(\d+)月(\d+)日/
# # MatchDataオブジェクトを取得
# p Regexp.last_match
# # マッチした部分全体を取得する
# p Regexp.last_match(0)





# # Userクラスを定義する
# # class User
# #   attr_reader :first_name, :last_name, :age

# #   def initialize(first_name, last_name, age)
# #     @first_name = first_name
# #     @last_name = last_name
# #     @age = age
# #   end

# #   # 氏名を作成するメソッド
# #   def full_name(user)
# #     "#{user.first_name} #{user.last_name}"
# #   end
# # end


# # # ユーザのデータを作成する
# # users = []
# # users << User.new('Alice', 'Ruby', 20)
# # users << User.new('Bob', 'Python', 30)

# # # ユーザのデータを表示する
# # users.each do |user|
# #   puts "氏名: #{full_name(user)}、年齢: #{user.age}"
# # end

# # タイプミスしたときにエラーになる
# # users[0].first_mame

# # 勝手にfirst_nameを変更できない
# # users[0]first_name = 'Carol'




# # class User
# #   def initialize(name)
# #     # わざとインスタンス変数をコメントアウトする
# #     # @name = name
# #   end

# #   def hello
# #     "Hello, I am #{@name}."
# #   end
# # end
# # user = User.new('Alice')
# # # @nameを参照するとnilになる
# # user.hello



# # @nameをクラスの外部から参照するためのメソッド
# # def name
# #   @name
# # end

# # これは、アクセサメソッドで書き換えられる
# # @nameと@ageへのアクセサメソッドを定義する
# # attr_accessor :name, :age


# ### クラスメソッドはひとつひとつのインスタンスに含まれるデータは使わないメソッドを定義したいときに定義

# # class User
# #   def initialize(name)
# #     @name = name
# #   end

# #   def self.create_users(names)
# #     names.map do |name|
# #       User.new(name)
# #     end
# #   end

# #   def hello
# #     "Hello, I am #{@name}"
# #   end
# # end
# # names = ['Alice', 'Bob', 'Carol']
# # # クラスメソッドの呼び出し
# # users = User.create_users(names)
# # users.each do |user|
# #   # インスタンスメソッドの呼び出し
# #   puts user.hello
# # end


# ### 定数
# # 定数はインスタンスメソッド内でもクラスメソッド内でも同じ方法で参照できる


# ### クラスメソッドやクラス構文直下のself
# class Foo
#   # このputs はクラス定義の読み込み時に呼び出される
#   puts "クラス構文の直下のself: #{self}"

#   def self.bar
#     puts "クラスメソッドないメソッド内のself: #{self}"
#   end

#   def baz
#     puts "インスタンスメソッド内のself: #{self}"
#   end
# end
# # =>クラス構文の直下のself: Foo

# Foo.bar # =>クラスメソッドないメソッド内のself: Foo
# foo = Foo.new
# foo.baz # =>インスタンスメソッド内のself: #<Foo:0x00007fa9a4002288>



# ### superでスーパークラスのメソッドを呼び出す
# class Product
#   attr_reader :name, :price

#   def initialize(name, price)
#     @name = name
#     @price = price
#   end
# end
# product = Product.new('A great movie', 1000)
# p product.name #=> "A great movie"
# p product.price #=> 1000

# class DVD < Product
#   attr_reader :running_time

#   def initialize(name, price, running_time)
#     # スーパークラスのinitializeを呼び出す
#     super(name, price)
#     # DVDクラス独自の属性
#     @running_time = running_time
#   end
# end
# dvd = DVD.new('A great movie', 1000, 120)
# p dvd.name #=> "A great movie"
# p dvd.price #=> 1000
# p dvd.running_time #=> 120


# ### メソッドのオーバーライド
# class Product
#   attr_reader :name, :price

#   def initialize(name, price)
#     @name = name
#     @price = price
#   end

#   def to_s
#     "name: #{name}, price: #{price}"
#   end
# end


# class DVD < Product
#   attr_reader :running_time

#   def initialize(name, price, running_time)
#     super(name, price)
#     @running_time = running_time
#   end

#   # def to_s
#   #   "name: #{name}, price: #{price}, running_time: #{running_time}"
#   # end
#   # superでスーパークラスのto_sメソッドを呼び出す
#   def to_s
#     "#{super}, running_time: #{running_time}"
#   end
# end

# dvd = DVD.new('An awesome film', 3000, 120)
# p dvd.to_s #=> "name: An awesome film, price: 3000, running_time: 120"


# ## メソッドの公開レベル
# ### private
# # privateメソッドではself付きで呼び出すとエラーになる
# # selfというレシーバを指定してメソッドを呼び出したことになるから
# # selfを省略すればエラーは発生しない

# class User
#   def hello
#     # nameメソッドはprivateなのでselfをつけるとエラーになる
#     "Hello, I am #{self.name}."
#     # selfなしでnameメソッドを呼び出す
#     "Hello, I am #{name}."
#   end

#   private

#   def name
#     'Alice'
#   end
# end
# user = User.new
# p user.hello


# ### クラスメソッドをprivateにしたい場合
# # class User
# #   class << self
# #     # class << self構文ならクラスメソッドでもprivateが機能する
# #     private

# #     def hello
# #       'Hello'
# #     end
# #   end
# # end
# # User.hello

# ### class << selfを使わない場合
# class User
#   def self.hello
#     'Hello'
#   end
#   # 後からクラスメソッドをprivateに変更する
#   private_class_method :hello
# end
# User.hello



# class User
#   # いったんpublic メソッドとして定義
#   def foo
#     'foo'
#   end

#   def bar
#     'bar'
#   end

#   # fooとbarをprivateメソッドに変更
#   private :foo, :bar

#   # bazはpublicメソッド
#   def baz
#     'baz'
#   end
# end

# user = User.new
# # fooとbarはprivateだから呼び出せない
# user.foo
# user.bar
# user.baz


### protectedメソッド
# 外部には公開したくないが、同じクラスやサブクラスの中であればレシーバ付きで呼び出せるようにする

# class User
#   # weightは外部に公開しない
#   attr_reader :name

#   def initialize(name, weight)
#     @name = name
#     @weight = weight
#   end

#   # 自分がother_userより重い場合はtrue
#   def hevier_than?(other_user)
#     other_user.weight < @weight
#   end
# end


# ### weightメソッドをprotectedにする
# def hevier_than?(other_user)
#   other_user.weight < @weight
# end

# protected


# # protectedメソッドなので同じクラスかサブクラスであればレシーバ付きで呼び出せる
# def weight
#   @weight
# end
# alice = User.new('Alice', 50)
# bob = User.new('Bob', 60)

# alice.hevier_than?(bob) #=> false
# bob.hevier_than?(alice) #=> true
