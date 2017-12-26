function system_log(x,y)
  interval = 1
  font="Inconsolata"
  font_size = 12.5
  spacing = 1.2
  local color = color4

  timer = (updates % interval)
  if timer == 0 or conky_start == 1 then
    sl_content_table = {}
    os.execute(curdir .. "/journal_dump.sh")
    file = io.open(curdir .. "/.tmp/journal.txt", "r")
    for line in file:lines() do
      local content = line
      table.insert(sl_content_table, content)
    end
    file:close()
  end
  n = 1
  for i, line in ipairs (sl_content_table) do
    local content = line
    y = y + font_size*spacing
    displaytext(x,y,content,font,font_size,color)
    n = n+1
  end
end
