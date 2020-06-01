def convert_hash_syntax(old_syntax)
  # 何もせずに返す
  old_syntax.gsub(/:(\w+) *=> */, '\1: ')
end