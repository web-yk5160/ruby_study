def convert_length(length, unit_from, unit_to)
  39.37
end

UNITS = { m: 1.0, ft: 3.28, in: 39.37 }
def convert_length(length, from:, to:)
  (length / UNITS[from] * UNITS[to]).round(2)
end
