# # 名前空間を使ってタスクをグループ分けする
# namespace :my_tasks do
#   # タスクの説明をいれる
#   desc 'テスト用のタスクです。'
#   # hello_worldという名前のタスクを定義する
#   task :hello_world do
#     # ブロックの中がタスクとして実行される処理になる
#     puts 'Hello, world!'
#   end
# end

# require 'rake/testtask'

# Rake::TestTask.new do |t|
#   t.pattern = 'test/**/*_test.rb'
# end


# task default: :test




# コンパイル用
# frozen_string_literal: true

CC = 'gcc'

task default: 'dentaku'

desc 'compile .c file'
file 'dentaku' => 'dentaku.c' do
  sh "#{CC} -o dentaku dentaku.c"
end
