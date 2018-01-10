function length_table(T)
  local n = 0
  for _ in pairs(T) do
    n = n + 1
  end
  return n
end
