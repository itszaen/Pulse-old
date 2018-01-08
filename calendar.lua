function calendar(x,y)
  local interval  = 600
  local init = 10
  local spacing = 1
  local font_size = 15
  local color = color5
  timer  = (updates % interval)

  if ic == 1 and (timer == 0 or conky_start) then
    os.execute("gcalcli calm > "..curdir.."/.tmp/calendar &")
  end
  if timer == init then
    local result = io.open(curdir.."/.tmp/calendar")
    if result ~= nil then
      calendar_t = {}
      for line in result:lines() do
        table.insert(calendar_t,line)
      end
      result:close()
    else
      file:close()
    end
  end
  if next(calendar_t) ~= nil then
    -- starts here
    local n = 1
    for i,line in ipairs(calendar_t) do
      text = line
      displaytext(x,y,text,font,font_size,color)
      y = y + font_size*spacing
      n = n + 1
    end
  end
end
