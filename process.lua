-- the cpu will display the same as ram if interval is bigger than 1!
function cpuprocess(x,y)
  spacing = 1
  font = "Inconsolata"
  font_size = 15
  color = color2
  interval = 2

  timer = (updates % interval)
  if timer == 0 or conky_start == 1 then
    result = io.popen("ps -e -o pid,comm,%cpu --sort=-%cpu | head -9 | sed 1d")
    cp_t = {}
    for line in result:lines() do
      table.insert(cp_t, line)
    end
    result:close()
  end
  n = 1
  for i, line in ipairs(cp_t) do
    text = line
    y = y + font_size*spacing
    displaytext(x,y,text,font,font_size,color)
    n = n+1
  end
end

function ramprocess(x,y)
  spacing = 1
  font = "Inconsolata"
  font_size = 15
  color = color2
  interval = 2

  timer = (updates % interval)
  if timer == 0 or conky_start == 1 then
    result = io.popen("ps -e -o pid,comm,%mem --sort=-%mem | head -9 | sed 1d")
    mp_t = {}
    for line in result:lines() do
      table.insert(mp_t, line)
    end
    result:close()
  end
  n = 1
  for i, line in ipairs(mp_t) do
    text = line
    y = y + font_size*spacing
    displaytext(x,y,text,font,font_size,color)
    n = n+1
  end
end
