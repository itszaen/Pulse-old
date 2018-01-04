function system_storage(x,y)
    interval = 10
    font="Inconsolata"
    font_size = 18
    spacing = 1.4
    local color = color2

    timer = (updates % interval)
    if timer == 0 or conky_start == 1 then
    ss_t = {}
      result = io.popen("df -h")
      for line in result:lines() do
        table.insert(ss_t, line)
      end
      result:close()
    end
    n = 1
    for i, line in ipairs(ss_t) do
      text = line
      y = y + font_size*spacing
      displaytext(x,y,text,font,font_size,color)
      n = n + 1
    end
end
