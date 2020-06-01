#!/usr/bin/env ruby

# 標準入力をプール
buffer = []
while str = $stdin.gets
  buffer << str
end

# 標準入力が終了したら以下を実行

$stdout.puts '**** start ****'

# ブールした内容を出力
idx = 0
while str = buffer[idx]
  $stdout.print "#{idx + 1} #{str}"
  idx += 1
end

$stdout.puts '**** end ****'
