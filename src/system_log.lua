function system_log(x,y)
  interval = 1
  font_size = 12.5
  spacing = 1.2
  local color = color4

  timer = (updates % interval)
  if timer == 0 or conky_start == 1 then
    result = io.popen("journalctl -n 14 | sed 1d | awk '{$1=$2=$4=\"\"; print $0}' | sed 's/  //' | sed 's/  / /' | fold -w 80 -s")
    sl_t = {}
    for line in result:lines() do
      table.insert(sl_t,line)
    end
    result:close()
  end
  if next(sl_t) == nil then
    return
  end
  local n = 1
  for i, line in ipairs (sl_t) do
    y = y + font_size*spacing
    if y >= 1030 then
    else
      local text = line
      displaytext(x,y,text,font,font_size,color)
      n = n+1
    end
  end
end
