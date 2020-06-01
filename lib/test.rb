### 定数をprivateにする
# class  Product
#   DEFAULT_PRICE = 0
#   # 定数をプライベートにする
#   # private_constant :DEFAULT_PRICE
# end

# # privateなのでクラスの外部からは参照できない
# Product::DEFAULT_PRICE
# # =>private constant Product::DEFAULT_PRICE referenced (NameError)

# # クラスを凍結する
# Product.freeze
# # freezeすると変更できない
# Product::DEFAULT_PRICE = 5000

### freezeはデメリットの方が多いので普通はしない
# class Product
#   NAME = 'A product'
#   SOME_NAMES = ['Foo', 'Bar', 'Baz']
#   SOME_PRICES = { 'Foo' => 1000, 'Bar' => 2000, 'Baz' => 3000 }
# end

# # 文字列を破壊的に大文字にする
# Product::NAME.upcase!
# Product::Name

# # 配列に新しい要素を追加する
# Product::SOME_NAMES << 'Hoge'
# Product::SOME_NAMES

# # ハッシュに新しいキーを追加
# Product::SOME_PRICES['Hoge'] = 4000
# Product::SOME_PRICES




# class Product
#   # 配列と中身の文字列を凍結する
#   SOME_NAMES = ['Foo'.freeze, 'Bar'.freeze, 'Baz'.freeze].freeze

#   def self.names_without_foo(names = SOME_NAMES)
#     # nameがデフォルト値だと、以下のコードは定数のSOME_NAMESを破壊的に変更している
#     names.delete('Foo')
#     names
#   end
# end

# Product.names_without_foo

# # 定数の中身が変わる
# p Product::SOME_NAMES


# class Product
#   # クラスインスタンス変数
#   @name = 'Product'

#   def self.name
#     # クラスインスタンス変数
#     @name
#   end

#   def initialize(name)
#     # インスタンス変数
#     @name = name
#   end

#   def name
#     # インスタンス変数
#     @name
#   end
# end


# class User
#   def hello
#     'Hello'
#   end

#   # helloメソッドのエイリアスメソッドとしてgreetingメソッドを定義
#   # alias 新しい名前 元の名前
#   alias greeting hello
# end


# class User
#   # freezeメソッドの定義を削除
#   undef freeze
# end
# user = User.new
# # freezeメソッドを呼び出すとエラーになる
# p user.freeze #=>undefined method `freeze' for #<User:0x00007fc779059018> (NoMethodError)



# class User
#   class BloodType
#     attr_reader :type

#     def initialize(type)
#       @type = type
#     end
#   end
# end

# blood_type = User::BloodType.new('B')
# p blood_type.type #=> "B"



# class Product
#   attr_reader :code, :name

#   def initialize(code, name)
#     @code = code
#     @name = name
#   end


#   def ==(other)
#     if other.is_a?(Product)
#       # 商品コードが一致すれば同じProductと見なす
#       code == other.code
#     else
#       # otherがProductでなければ常にfalse
#       false
#     end
#   end
# end

# a = Product.new('A-001', 'A great movie')
# b = Product.new('B-001', 'An awesome movie')
# c = Product.new('A-001', 'A great movie')

# # 商品コードが一致すればtrue
# p a == b #=> false
# p a == c #=> true

# # Product以外の比較はfalse
# p a == 1 #=> false
# p a == 'a' #=> false


# a = 'abc'
# b = 'abc'
# a.equal?(b)

# c = a
# a.equal?(c)



# a = 'japan'
# b = 'japan'
# # eql?が真なら、hash値も同じ
# p a.hash #=> 1581763444924233365
# p b.hash #=> 1581763444924233365

# c = 1
# d = 1.0
# # eql?が偽なら、hash値も異なる
# c.eql?(d)
# p c.hash #=> 2944556381439206670
# p d.hash #=> 2652082627281967290



# class String
#   # 文字列をランダムにシャッフルする
#   def shuffle
#     chars.shuffle.join
#   end
# end

# s = 'Hello, I am Alice'
# p s.shuffle #=>"limeHI eAo acll, "
# p s.shuffle #=> "lo aelmH eI iAlc,"



# class User
#   def initialize(name)
#     @name = name
#   end

#   def hello
#     "Hello, #{@name}"
#   end
# end
# # モンキーパッチを当てるためにUserクラスを再オープンする
# class User
#   # 既存のhelloメソッドはhello_originalとして呼び出せるようにしておく
#   alias hello_original hello

#   # helloメソッドにモンキーパッチを当てる
#   # (元々実装されていたhelloメソッドも再利用する)
#   def hello
#     "#{hello_original}じゃなくて、#{@name}さん、こんにちは!"
#   end
# end

# # モンキーパッチをあてたhelloメソッドの挙動を確認する
# user = User.new('Alice')
# p user.hello #=>"Hello, Aliceじゃなくて、Aliceさん、こんにちは!"




# alice = 'I am Alice'
# bob = 'I am Bob'

# # aliceオブジェクトにだけ、shuffleメソッドを定義する
# def alice.shuffle
#   chars.shuffle.join
# end

# # aliceはshuffleメソッドを持つが、bobは持たない
# p alice.shuffle #=> "A Il camie"
# p bob.shuffle #=>undefined method `shuffle' for "I am Bob":String (NoMethodError)




# Rubyが気にするのは「コードが実行する瞬間に、そのメソッドが呼び出せるか否か」であり、「そのオブジェクトのクラス(データ型)が何か」ではない

# helloメソッドを持つGreeterモジュールを定義
# module Greeter
#   def hello
#     'hello'
#   end
# end

# # モジュールのインスタンスは作成できない
# greeter = Greeter.new #=> undefined method `new' for Greeter:Module (NoMethodError)

# # ほかのモジュールを継承して新しいモジュールを作ることはできない
# module AwesomeGreeter < Greeter
# end #=> syntax error, unexpected '<' module AwesomeGreeter < Greeter




# ログ出力用のメソッドを提供するモジュール
# module Loggable
#   def log(text)
#     puts "[LOG] #{text}"
#   end
# end

# class Product
#   # 上で作ったモジュールをincludeする
#   include Loggable

#   def title
#     # logメソッドはLoggableモジュールで定義したメソッド
#     log 'title is called'
#     'A greate movie'
#   end
# end

# class User
#   # こちらも同じようにincludeする
#   include Loggable

#   def name
#     # Loggableモジュールのメソッドが使える
#     log 'name is called.'
#     'Alice'
#   end
# end

# product = Product.new
# p product.title


# user = User.new
# p user.name



# extendを使うと、モジュール内のメソッドをそのクラスの特異メソッド(クラスメソッド)にすることができる
# # モジュールをincludeするときと同じ
# module Loggable
#   def log(text)
#     puts "[LOG] #{text}"
#   end
# end


# class Product
#   # Loggableモジュールのメソッドを特異メソッド(クラスメソッド)としてミックスインする
#   extend Loggable

#   def self.create_products(names)
#     # logメソッドをメソッド内で呼び出す
#     # つまりlogメソッド自体もクラスメソッドになっている
#     log 'create_products is called'
#     'A greate movie'
#   end
# end

# # クラスメソッド経由でlogメソッドが呼び出される
# Product.create_products([])  #=> [LOG] create_products is called

# # Productクラスのクラスメソッドとして直接呼び出すことも可能
# Product.log('Hello.') #=>[LOG] Hello.





### includeされたモジュールの有無を確認する
# module Loggable
#   def log(text)
#     puts "[LOG] #{text}"
#   end
# end


# class Product
#   include Loggable

#   def self.create_products(names)
#     log 'create_products is called'
#     'A greate movie'
#   end
# end


# p Product.include?(Loggable) #=> true
# p Product.included_modules #=> [Loggable, Kernel]
# p Product.ancestors #=> [Product, Loggable, Object, Kernel, BasicObject]

# ### include先のモジュールを使うモジュール
# # priceというメソッドがinclude先に定義されていることを前提
# module Taggable
#   def price_tag
#     # priceメソッドはinclude先で定義されているはず、という前提
#     "#{price}円"
#   end
# end

# class Product
#   include Taggable

#   def price
#     1000
#   end
# end

# product = Product.new
# p product.price_tag


# ### Enumerableモジュール
# 代表的なメソッドは`map`、`select`、`find`、`count`
# include先のメソッドで`each`メソッドが実装されていることが条件

# ### Comparableモジュールと<=>演算子
# これをincludeすると、以下のメソッドが使える
# `<`、`<==`、`>`、`>=`、`between?`
# include先のクラスで<=>演算子を実装しておくことが条件
# * aがbより大きいなら正の整数
# * aとbが等しいなら0
# * aがbより小さいなら負の整数
# * aとbが比較できない場合はnil

# p 2 <=> 1
# p 2 <=> 2
# p 1 <=> 2
# p 2 <=> 'abc'
# #=> 1
# # 0
# # -1
# # nil



### Comparableモジュールを独自のクラスにincludeして使うことができる
# class Tempo
#   include Comparable

#   attr_reader :bpm

#   # bpmはBeats Per Minuteの略で音楽の速さを表す単位
#   def initialize(bpm)
#     @bpm = bpm
#   end

#   # <=>はComparableモジュールで使われる演算子
#   def <=>(other)
#     if other.is_a?(Tempo)
#       # bpm同士を<=>で比較した結果を返す
#       bpm <=> other.bpm
#     else
#       # 比較できない場合はnilを返す
#       nil
#     end
#   end

#   def inspect
#     "#{bpm}bpm"
#   end
# end

# p t_120 = Tempo.new(180)
# p t_180 = Tempo.new(180)

# p t_120 > t_180
# p t_120 <= t_180
# p t_120 == t_180
# Comparableモジュールと<=>演算子のおかげで、Tempoクラスは比較演算子を使って大小を比較できる


# クラスインスタンス変数とインスタンス変数は間違いやすいと感じたので、コードを読むときは注意して読むようにする


# module NameChanger
#   def change_name
#     # include先のクラスインスタンス変数を変更する
#     @name = 'ありす'
#   end
# end

# class User
#   include NameChanger

#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end
# end

# user = User.new('alice')
# p user.name #=> "alice"

# # モジュールで定義したメソッドでインスタンス変数を書き換える
# user.change_name
# p user.name #=> "ありす"



# module NameChanger
#   def change_name
#     # セッターメソッド経由でデータをする
#     self.name = 'ありす'
#   end
# end

# class User
#   include NameChanger

#   attr_accessor :name

#   def initialize(name)
#     @name = name
#   end
# end

# # Userクラスの使い方は同じ
# user = User.new('alice')
# user.change_name
# p user.name #=> "ありす"






# module Loggable
#   def log(text)
#     puts "[LOG] #{text}"
#   end
# end

# s = 'abc'

# # 文字列は通常logメソッドを持たない
# p s.log('Hello')

# # 文字列にloggableモジュールのメソッドを特異メソッドとしてミックスインする
# s.extend(Loggable)

# # Loggableモジュールのメソッドが呼び出せるようになる
# p s.log('Hello')



# module Baseball
#   # これはBaseballモジュールに属するSecondクラス
#   class Second
#     def initialize(player, uniform_number)
#       @player = player
#       @uniform_number = uniform_number
#     end
#   end
# end

# module Clock
#   # これはClockモジュールに属するSecondクラス
#   class Second
#     def initialize(digits)
#       @digits = digits
#     end
#   end
# end
# # 二塁手のAlice
# p Baseball::Second.new('Alice', 13) #<Baseball::Second:0x00007fc2ac83b190 @player="Alice", @uniform_number=13>
# # 時計の13秒を作成
# p Clock::Second.new(13) #<Clock::Second:0x00007fc2ac83a308 @digits=13>


# # すでにBaseballモジュールが定義されている
# module Baseball
# end

# # モジュール名::クラス名の形でクラスを定義できる
# class Baseball::Second
#   def initialize(player, uniform_number)
#     @player = player
#     @uniform_number = uniform_number
#   end
# end





# module Loggable
#   # 特異メソッドとしてメソッドを定義する
#   def self.log(text)
#     puts "[LOG] #{text}"
#   end
# end

# # ほかのクラスにミックスインしなくてもモジュール単体でそのメソッドを呼び出せる
# p Loggable.log('Hello')



# module Loggable
#   class << self
#     def log(text)
#       puts "[LOG] #{text}"
#     end
#   end

#   # 以下、ほかの特異メソッドを定義
# end


# p Loggable.log('Hello')




# module Loggable
#   def log(text)
#     puts "[LOG] #{text}"
#   end
#   # logメソッドをミックスインとしても、モジュールの特異メソッドとしても使えるようにする
#   module_function :log
# end

# # モジュールの特異メソッドとしてlogメソッドを呼び出す
# Loggable.log('Hello.')

# # Loggableモジュールをincludeしたクラスを定義する
# class Product
#   include Loggable

#   def title
#     # includeしたLoggableモジュールのlogメソッドを呼び出す
#     log 'title is called.'
#     'A great movie'
#   end
# end

# # ミックスインとしてlogメソッドを呼び出す
# product = Product.new
# p product.title



# モジュールの特異メソッドとしてsqrt(平方根)メソッドを利用
# Math.sqrt(2)

# class Calculator
#   include Math

#   def calc_sqrt(n)
#     # ミックスインとしてMathモジュールのsqrtメソッドを使う
#     sqrt(n)
#   end
# end

# calculator = Calculator.new
# p calculator.calc_sqrt(2)



# # AwesomeApiは何らかのWebAPIを利用するライブラリ、という想定
# module AwesomeApi
#   # 設定値を保持するクラスインスタンス変数を用意する
#   @base_url = ''
#   @debug_module = false

#   # クラスインスタンス変数を読み書きするための特異メソッドを定義
#   class << self
#     def base_url =(value)
#       @base_url = value
#     end

#     def base_url
#       @base_url
#     end

#     def debug_mode=(value)
#       @debug_mode = value
#     end

#     def debug_mode
#       @debug_mode
#     end

#     # 上ではわかりやすくするために明示的にメソッドを定義したが、本来は以下の1行で済む
#     attr_accessor :base_url, :debug_mode
#   end
# end

# # 設定値を保存する
# p AwesomeApi.base_url = 'http://example.com'
# p AwesomeApi.debug_mode = true

# # 設定値を参照する
# AwesomeApi.base_url
# AwesomeApi.debug_mode



# module A
#   def to_s
#     "<A> #{super}"
#   end
# end

# module B
#   def to_s
#     "<B> #{super}"
#   end
# end

# class Product
#   def to_s
#     "<Product> #{super}"
#   end
# end

# class DVD < Product
#   include A
#   include B

#   def to_s
#     "<DVD> #{super}"
#   end
# end


# p DVD.ancestors
#=> [DVD, B, A, Product, Object, Kernel, BasicObject]



# module Greeting
#   def hello
#     'hello'
#   end
# end

# module Aisatsu
#   # 別のモジュールをincludeする
#   include Greeting

#   def konnichiwa
#     'こんにちは'
#   end
# end

# class User
#   # Aisatsuモジュールだけをincludeする
#   include Aisatsu
# end

# user = User.new

# # Aisatsuモジュールのメソッドを呼び出す
# p user.konnichiwa #=> "こんにちは"
# p user.hello #=> "hello."
# p User.ancestors



# module A
#   def to_s
#     "<A> #{super}"
#   end
# end

# class Product
#   # includeではなくprependを使う
#   prepend A

#   def to_s
#     "<Product> #{super}"
#   end
# end

# product = Product.new
# p product.to_s
# #=> "<A> <Product> #<Product:0x00007f8ae800a1e8>"

# # includeでモジュールをミックスインした場合
# p product.to_s
# #=> "<Product> <A> #<Product:0x00007fb06e809528>"

# # prependをした場合
# # ミックスインしたクラスよりも先にモジュールからメソッドが検索される
# p Product.ancestors
# #=> [A, Product, Object, Kernel, BasicObject]

# # includeをした場合
# p Product.ancestors
# #=>  [Product, A, Object, Kernel, BasicObject]




# # 以下Productクラスは外部ライブラリで定義されている想定
# class Product
#   def name
#     "A great film"
#   end
# end

# # prependするためのモジュールを定義する
# module NameDecorator
#   def name
#     # pretendするとsuperはミックスインした先のクラスのnameメソッドを呼び出す
#     "<<#{super}>>"
#   end
# end

# # 既存メソッドを変更するためにProductクラスを再オープンする
# class Product
#   # includeではなくprependでミックスインする
#   prepend NameDecorator
# end

# class User
#   def name
#     'Alice'
#   end
# end

# class User
#   # prependを使えばUserクラスのnameメソッドも置き換えることができる
#   prepend NameDecorator
# end

# user = User.new
# p user.name

# # エイリアスメソッドを使った場合と同じ結果が得られる
# product = Product.new
# p product.name

# # 直接prependメソッドを使って呼び出しても良い
# p Product.prepend NameDecorator


# 大規模なプログラムの開発現場でRubyのプログラムを書く機会が会ったらmoduleの章を見直す




# require './string_shuffle'

# # ここではまだshuffleメソッドが使えない
# # puts 'Alice'.shuffle

# # トップレベルでusingすると、ここからファイルの最後までshuffleメソッドが有効になる
# using StringShuffle

# class User
#   def initialize(name)
#     @name = name
#   end

#   def shuffled_name
#     @name.shuffle
#   end
# end

# user = User.new('Alice')
# puts user.shuffled_name

# puts 'Alice'.shuffle

# # ほかのファイルではshuffleメソッドは使えない




# puts 'Start.'
# module Greeter
#   def hello
#     'hello'
#   end
# end

# # 例外処理を組み込んで例外に対処する
# begin
#   greeter = Greeter.new
# rescue
#   puts '例外が発生したが、このまま続行する'
# end

# # 例外処理を組み込んだので、最後まで実行可能
# puts 'End.'

# #=> Start.
# # 例外が発生したが、このまま続行する
# # End.



# method_1にだけ例外処理を記述する
# def method_1
#   puts 'mothod_1 start.'
#   begin
#     method_2
#   rescue
#     puts '例外が発生しました'
#   end
#   puts 'method_1 end.'
# end

# def method_2
#   puts 'method_2 start.'
#   method_3
#   puts 'method_2 end.'
# end

# def method_3
#   puts 'method_3 start'
#   # ZeroDivisionErrorを発生させる
#   1 / 0
#   puts 'method_3 end.'
# end

# # 処理を開始する
# method_1
# => mothod_1 start.
# method_2 start.
# method_3 start
# 例外が発生しました
# method_1 end.

# 例外を捕捉したmethod_1だけが処理を続行でき、method_2とmethod_3は例外が発生した時点で処理が中断している


# ### 例外オブジェクトから情報を取得する
# begin
#   1 / 0
# rescue => e
#   puts "エラークラス: #{e.class}"
#   puts "エラーメッセージ: #{e.message}"
#   puts "バックトレース -----"
#   puts e.backtrace
#   puts "-----"
# end



# begin
#   'abc'.foo
# rescue ZeroDivisionError
#   puts "0で除算しました"
# rescue NoMethodError
#   puts "存在しないメソッドが呼び出されました"
# end



# begin
#   # ZeroDivisionErrorを発生させる
#   1/ 0
# rescue NoMethodError
#   puts "NoMethodErrorです"
# rescue NameError
#   puts "NameErrorです"
# rescue #例外クラスを指定しない
#   puts "その他のエラーです"
# end



# retry_count = 0
# begin
#   puts '処理を開始します'
#   # わざと例外を発生させる
#   1 / 0
# rescue
#   retry_count += 1
#   if retry_count <= 3
#     puts "retryします。(#{retry_count}回目)"
#     retry
#   else
#     puts 'retryに失敗しました'
#   end
# end
# #=> 処理を開始します
# # retryします。(1回目)
# # 処理を開始します
# # retryします。(2回目)
# # 処理を開始します
# # retryします。(3回目)
# # 処理を開始します
# # retryに失敗しました



# def currency_of(country)
#   case country
#   when :japan
#     'yen'
#   when :us
#     'dollar'
#   when :india
#     'rupee'
#   else
#     # raiseメソッドに例外クラスのインスタンスを渡す(newの引数はエラーメッセージになる)
#   raise ArgumentError.new("無効な国名です。#{country}")
#   end
# end

# currency_of(:itary)
# #=> 無効な国名です。itary (ArgumentError)

### rescueすべき例外は少ない
### 安易にrescueは使わずにRailsなどのフレームワークの共通処理に全部丸投げする方が安全
### rescueしたら情報を残す

# 大量のユーザにメールを送信する(例外が起きても最後まで続行する)
# users.each do |user|
#   begin
#     # メール送信を実行する
#     send_mail_to(user)
#   rescue => e
#     # 例外クラス名、エラーメッセージ、バックトレースをターミナルに出力
#     puts "#{e.class}: #{e.message}"
#     puts e.backtrace
#   end
# end

# require 'date'

# def convert_heisei_to_date(heisei_text)
#   m = heisei_text.match(/平成(?<jp_year>\d+)年(?<month>\d+)月(?<day>\d+)日/)
#   year = m[:jp_year].to_i + 1988
#   month = m[:month].to_i
#   day = m[:day].to_i
#   # 正しい日付の時のみDateオブジェクトを作成
#   if Date.valid_date?(year, month, day)
#     Date.new(year, month, day)
#   end
# end

# p convert_heisei_to_date('平成28年12月31日')
# p convert_heisei_to_date('平成28年99月99日')


# file = File.open('some.txt', 'w')

# begin
#   # ファイルに文字列を書き込む
#   file << 'Hello'
# ensure
#   # 例外の有無にかかわらず必ずファイルをクローズする
#   file.close
# end

#  ブロック付きでオープンすると、メソッドの実行後に自動的にクローズする
# file.open('some.txt','w') do |file|
#   file << 'Hello'
# end

### ブロックの実行中に例外が発生した場合も、openメソッドが必ずクローズ処理を実行

# File.open('some.txt','w') do |file|
#   file << 'Hello'
#   # わざと例外を発生させる
#   1 / 0
# end
# 例外は発生するがopenメソッドによってクローズ処理自体は必ず行われる
# => divided by 0 (ZeroDivisionError)



# require 'date'

# def to_date(string)
#   begin
#     # 文字列のパースを試みる
#     Date.parse(string)
#   rescue ArgumentError
#     # パースできない場合はnilを返す
#     nil
#   end
# end

# # パース可能な文字列を渡す
# p to_date('2017-01-01')
# #=> #<Date: 2017-01-01 ((2457755j,0s,0n),+0s,2299161j)>

# # パース不可能な文字列を渡す
# p to_date('abcdef')
# #=>  nil

# ### 上記のコードをrescue修飾子を使って書き換えるとこうなる
# 例外処理を細かく書きたい場合はbegin~endで書く
# def to_date(string)
#   Date.parse(string) rescue nil
# end

# p to_date('2017-01-01')
# #=> #<Date: 2017-01-01 ((2457755j,0s,0n),+0s,2299161j)>

# p to_date('abcdef')
# # =>nil


# # rescue節で例外情報を変数eに格納する
# begin
#   1 / 0
# rescue => e
#   puts "#{e.class} #{e.message}"
#   puts e.backtrace
# end
# # =>ZeroDivisionError divided by 0

# # 組み込み変数の$!と$@に格納された例外情報を使う
# begin
#   1 / 0
# rescue
#   puts "#{$!.class} #{$!.message}"
#   puts $@
# end
# # =>ZeroDivisionError divided by 0



# def fizz_buzz(n)
#   if n % 15 == 0
#     'Fizz Buzz'
#   elsif n % 3 == 0
#     'Fizz'
#   elsif n % 5 == 0
#     'Buzz'
#   else
#     n.to_s
#   end
# rescue => e
#   # 発生した例外をログやメールに残す(ここではputsを代用)
#   puts "[LOG] エラーが発生しました: #{e.class} #{e.message}"
#   # 捕捉した例外を再度発生させて、プログラム自体を異常終了させる
#   raise
# end

# p fizz_buzz(nil)
# # => NoMethodError undefined method `%' for nil:NilClass




# class NoCountryError < StandardError
#   # 国名を属性として取得できるようにする
#   attr_reader :country

#   def initialize(message, country)
#     @country = country
#     super("#{message} #{country}")
#   end
# end

# def currency_of(country)
#   case country
#   when :japan
#     'yen'
#   when :us
#     'dollar'
#   when :india
#     'rupee'
#   else
#     # NoCountryErrorを発生させる
#     raise NoCountryError.new('無効な国名です。', country)
#   end
# end

# begin
#   currency_of(:italy)
# rescue NoCountryError => e
#   # エラーメッセージと国名を出力する
#   puts e.message
#   puts e.country
# end
# # => 無効な国名です。 italy
# # italy


# def greeting
#   puts 'おはよう'
#   # 2個の引数をブロックに渡す
#   text = yield 'こんにちは', 12345
#   puts text
#   puts 'こんばんは'
# end

# greeting do |text|
#   # ブロック引数が1つあれば、2つめの引数は無視される
#   text * 2
# end
# # => おはよう
# # こんにちはこんにちは
# # こんばんは

# def greeting
#   puts 'おはよう'
#   # 1個の引数をブロックに渡す
#   text = yield 'こんにちは'
#   puts text
#   puts 'こんばんは'
# end

# greeting do |text, other|
#   # ブロック引数が2つあれば、2つめの引数はnilになる
#   text * 2 + other.inspect
# end
# # => おはよう
# # こんにちはこんにちはnil
# # こんばんは




# def greeting(&block)
#   puts 'おはよう'
#   text =
#     if block.arity == 1
#       # ブロック引数が1個の場合
#       yield 'こんにちは'
#     elsif block.arity == 2
#       # ブロック引数が2個の場合
#       yield 'こんに', 'ちは'
#     end
#     puts text
#     puts 'こんばんは'
# end


# # 1個のブロック引数でメソッドを呼び出す
# greeting do |text|
#   text * 2
# end
# # => おはよう
# # こんにちはこんにちは
# # こんばんは

# # 2個のブロック引数でメソッドを呼び出す
# greeting do |text_1, text_2|
#   text_1 * 2 + text_2 * 2
# end
# # => おはよう
# # こんにちはこんにちは
# # こんばんは


# # "Hello!"という文字列を返すProcオブジェクトを作成
# hello_proc = Proc.new do
#   'Hello'
# end

# # do..endの代わりに{}を使っても良い
# hello_proc = Proc.new { 'Hello' }

# p hello_proc.call

# add_proc = Proc.new { |a, b| a + b }
# p add_proc.call(10, 20)

# # Proc.newの代わりにprocメソッドを使う
# add_proc = proc { |a , b| a + b }
# p add_proc.call(10, 20)



# def greeting(&block)
#   puts 'おはよう'
#   text = block.call('こんにちは')
#   puts text
#   puts 'こんばんは'
# end

# # Procオブジェクトを作成し、それをブロックの代わりとしてgreetingメソッドに渡す
# repeat_proc = Proc.new { |text| text * 2 }
# greeting(&repeat_proc)
# # =>おはよう
# # こんにちはこんにちは
# # こんばんは




# # 3種類のProcオブジェクトを受け取り、それぞれのあいさつ文字列に適用するgreetingメソッド
# def greeting(proc_1, proc_2, proc_3)
#   puts proc_1.call('おはよう')
#   puts proc_2.call('こんにちは')
#   puts proc_3.call('こんばんは')
# end

# # greetingメソッドに渡すProcオブジェクトを用意する
# shuffle_proc = Proc.new { |text| text.chars.shuffle.join }
# repeat_proc = Proc.new { |text| text * 2 }
# question_proc = Proc.new { |text| "#{text}?" }

# # 3種類のProcオブジェクトをgreetingメソッドに渡す
# greeting(shuffle_proc, repeat_proc, question_proc)
# # => ようおは
# # こんにちはこんにちは
# # こんばんは?



# # Proc.newの場合(引数がnilでもエラーが起きないようにto_iメソッドを使う)
# add_proc = Proc.new { |a, b| a.to_i + b.to_i }
# # Proc.newは引数が1つまたは3つでも呼び出しが可能
# add_proc.call(10)
# add_proc.call(10, 20, 100)

# # ラムダの場合
# add_lambda = ->(a, b) { a.to_i + b.to_i }
# # ラムダは引数について厳密なので、引数が2個ちょうどでなければエラー
# add_lambda.call(10)
# add_lambda.call(10, 20, 30)





# add_proc = Proc.new { |a, b| a + b }
# # callメソッド
# add_proc.call(10, 20)
# # yieldメソッド
# add_proc.yield(10, 20)
# # .()を使う
# add_proc.(10, 20)
# # []を使う
# add_proc[10, 20]



# split_proc = :split.to_proc
# p split_proc
# # #<Proc:0x00007f8200067c58(&:split)>

# # 引数が1つの場合は'a-b-c-d e".splitと同じ(ホワイトスペースで分割する)
# p split_proc.call('a-b-c-d e')
# # ["a-b-c-d", "e"]

# # 引数が2つの場合は'a-b-c-d e".split('-')と同じ(指定された文字で分割する)
# p split_proc.call('a-b-c-d e', '-')
# # ["a", "b", "c", "d e"]

# # 引数が3つの場合は'a-b-c-d e".split('-', 3)と同じ(分割する個数を制限する)
# p split_proc.call('a-b-c-d e', '-', 3)


# def generate_proc(array)
#   counter = 0
#   # Procオブジェクトをメソッドの戻り値とする
#   Proc.new do
#     # ローカル変数のcounterを加算
#     counter += 10
#     # メソッド引数のarrayにcounterの値を追加する
#     array << counter
#   end
# end

# values = []
# sample_proc = generate_proc(values)
# p values

# # Procオブジェクトを実行するとgenerate_procメソッドの引数だったvaluesの中身が書き換えられる
# sample_proc.call
# p values

# # generate_procメソッド内のローカル変数coutnerも加算され続ける
# sample_proc.call
# p values


# def proc_break
#   # Proc.newでbreakを使う
#   f = Proc.new { |n| break n * 10 }
#   ret = [1, 2, 3].map(&f)
#   "ret: #{ret}"
# end

# def lambda_break
#   # lambdaでbreakを使う
#   f = ->(n) { break n * 10 }
#   ret = [1, 2, 3].map(&f)
#   "ret: #{ret}"
# end

# p proc_break #=> break from proc-closure (LocalJumpError)
# p lambda_break #=> "ret: [10, 20, 30]"

# ややこしくなるので、Proc.newやラムダのなかでreturnやbreakを使わないロジックを組むようにする



# class User

#   # def name=(name)のように書くつもりがうっかり書き間違えた
#   def name
#     # 右辺のnameは引数や変数ではなく、このnameメソッド自身になるので無限ループする
#     @name = name
#   end
# end

# user = User.new
# p user.name #=> stack level too deep (SystemStackError)


# def greeting
#   # greetingが呼ばれたことを確認
#   puts 'greeting start.'
#   return 'countryを入力してください' if country.nil?

#   if country == 'japan'
#     # 真の分岐に入ったことを確認
#     puts 'japan'
#     'こんにちは'
#   else
#     # 偽の分岐に入ったことを確認
#     puts 'other'
#     'hello'
#   end
# end



# def calc_fare(ticket)
#   from = STATION.index(ticket.stamped_at)
#   to = STATIONS.index(@name)
#   # to - from の結果をターミナルに出力しつつ、変数distanceに代入
#   distance = p to - from
#   FARES[distance - 1]
# end


# # メソッドチェーンを使ってるのでこのコードをデバッグ
# p '#043c78'.scan(/\w\w/).map(&:hex)
# # tapメソッドを使って、scanメソッドの戻り値をターミナルに表示する
# p '#043c78'.scan(/\w\w/).tap { |rgb| p rgb }.map(&:hex)
# #=> ["04", "3c", "78"]



# class User < ApplicationRecord
#   def facebook_username
#     info = facebook_auth.auth_info.info
#     # ログに変数info.nameの値を出力する
#     logger.debug "[DEBUG] info.name : #{info.name}"
#     info.name
#   end
# end


# require 'fileutils'
# # libディレクトリのhello_world.txtをhello_world.rbに移動(リネーム)する
# FileUtils.mv('./lib/hello_world.txt', './lib/hello_world.rb')


# require 'pathname'

# # カレントディレクトリ配下にあるlibディレクトリを表すオブジェクトを作る
# lib = Pathname.new('./lib')

# # ファイルか?
# p lib.file? #=> false

# # ディレクトリか?
# p lib.directory? #=> true

# # libディレクトリ配下にあるsample.txtへのパス文字列を作る
# p lib.join('sample.txt').to_s #=> "./lib/sample.txt"



# require 'csv'

# # CSVファイルの出力
# CSV.open('sample.csv', 'w') do |csv|
#   # ヘッダ行を出力する
#   csv << ['Name', 'Email', 'Age']
#   # 明細行を出力する
#   csv << ['Alice', 'alice@example.com', 20]
# end

# # タブ区切りのCSVファイルを読み込む
# CSV.foreach('sample.csv', col_sep: "\t") do |row|
#   # 各行について、1行目から3列目の値をターミナルに表示する
#   puts "1: #{row[0]}, 2: #{row[1]}, 3: #{row[2]}"
# end

# # jsonライブラリをrequireすると配列やハッシュでto_jsonメソッドが使えるようになる
# require 'json'

# user = { name: 'Alice', email: 'alice@example.com', age: 20 }

# # ハッシュをjson形式の文字列に変換する
# user_json = user.to_json
# puts user_json
# # =>{"name":"Alice","email":"alice@example.com","age":20}

# # JSONを文字列をパースしてハッシュに変換する
# JSON.parse(user_json)
# # =>{"name"=>"Alice", "email"=>"alice@example.com", "age"=>20}


# require 'yaml'

# # YAML形式のテキストデータを用意する
# yaml = <<TEXT
# alice:
#   name: 'Alice'
#   email: 'alice@example.com'
#   age: 20
# TEXT

# # YAMLテキストをパースしてハッシュに変換する
# users = YAML.load(yaml)

# # ハッシュに新しい要素を追加する
# users['alice']['gender'] = :female

# # ハッシュからYAMLテキストに変換する
# puts YAML.dump(users)
# # =>---
# # alice:
# #   name: Alice
# #   email: alice@example.com
# #   age: 20
# #   gender: :female


# ### evalメソッド
# # 文字列としてRubyのコードを記述する
# code = '[1, 2, 3].map { |n| m * 10 }'

# # evalメソッドに渡すと、文字列がRubyのコードとして実行される
# eval(code)

# ### バッククオートリテラル
# puts `cat lib/fizz_buzz.rb`

# # バッククオートの代わりに%xを使える
# puts %{cat lib/fizz_buzz.rb}

# ### sendメソッド
# str = 'a,b,c'
# # str.upcaseを呼ぶのと同じ
# str.send('upcase')

# # str.split(',')を呼ぶのと同じ
# str.send('split', ',')

# ### ツールを使ったコードレビューの自動化
# Brakemanというgemを使うとコードを解析してセキュリティ的に問題がありそうなコードを指摘してくれる
# https://github.com/presidentbeef/breakman
# ### rubocop
# 自分の書いたコードがRubyの標準的なコーディングルールに準拠しているかを自動的にチェックしてくれる
# https://github.com/rubocop-hq/rubocop

# ### RubyCritic
# コピーしたコードが多すぎたりしないかといった品質をチェックしてくれる
# https://github.com/whitesmith/rubycritic

# ### Rake
# Rubyで作られているビルドツール


# require 'faker'
# p Faker::Name.name


# ##Ruby on Railsの取得に向けた予備知識
# ### Railsの独自拡張になっている機能を理解する
# Railsが自動的に`require`を実行してくれる
# Railsは名前空間として使われているモジュールを自動的に作成する

# # Rails環境であれば、文字列に対してunderscoreメソッドが呼び出せる
# 'HelloWorld'.underscore

# # ActiveSupport::HashWithIndifferentAccessクラスを使ってハッシュを作成する
# countries = {"japan"=>"yen", "us"=>"dollar"}

# # このクラスを使うと、キーが文字列でもシンボルでも同等に扱われる
# p countries[:japan]
# p countries['japan']
# p countries[:us]
# p countries['us']




### テストの自動化に関する知識
Minitestではなく、Rspecとファクトリの組み合わせが使われることが多い
Rspec.describe 'Fizz Buzz' do
  example 'fizz_buzz' do
    expect('fizz_buzz(1)').to eq '1'
    expect('fizz_buzz(2)').to eq '2'
    expect('fizz_buzz(3)').to eq 'Fizz'
    # 以下省略
  end
end