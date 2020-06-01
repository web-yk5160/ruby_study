print 'Text?:'
text = gets.chomp
print 'Pattern?:'
pattern = gets.chomp

# 例外処理を組み込んで再入力可能にする
begin
  print 'Pattern?: '
  pattern = gets.chomp
  regexp = Regexp.new(pattern)
rescue RegexpError => e
  puts "Invalid pattern: #{e.message}"
  retry
end

regexp = Regexp.new(pattern)
matches = text.scan(regexp)
if matches.size > 0
  puts "Matched: #{matches.join(', ')}"
else
  puts "Nothing matched."
end