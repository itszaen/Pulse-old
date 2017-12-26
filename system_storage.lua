function system_storage(x,y)
    interval = 10
    font="Inconsolata"
    font_size = 18
    spacing = 1.4
    local color = color4

    timer = (updates % interval)
    if timer == 0 or conky_start == 1 then
    ss_content_table = {}
      file = io.popen("df -h")
      for line in file:lines() do
        local content = line
        table.insert(ss_content_table, content)
      end
      file:close()
    end
    n = 1
    for i, line in ipairs(ss_content_table) do
      local content = line
      y = y + font_size*spacing
      displaytext(x,y,content,font,font_size,color)
      n = n + 1
    end
end
