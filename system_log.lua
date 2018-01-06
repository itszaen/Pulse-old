function system_log(x,y)
  interval = 1
  font="Inconsolata"
  font_size = 12.5
  spacing = 1.2
  local color = color4

  timer = (updates % interval)
  if timer == 0 or conky_start == 1 then
    sl_t = {}
    result = io.popen("journalctl -n 14 | sed 1d | awk '{$1=$2=$4=\"\"; print $0}' | sed 's/  //' | sed 's/  / /' | cut -c1-80")
    for line in result:lines() do
      table.insert(sl_t,line)
    end
    result:close()
  end
  n = 1
  for i, line in ipairs (sl_t) do
    text = line
    y = y + font_size*spacing
    displaytext(x,y,text,font,font_size,color)
    n = n+1
  end
end
