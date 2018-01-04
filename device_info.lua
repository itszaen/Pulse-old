function cpu_info(x,y)
  font = "Inconsolata"
  font_size = 15
  color = color6
  if conky_start == 1 then
  text_t = {}
  local n = 1
    result = io.popen("lscpu | grep 'Model name' | sed 's/Model name://; s/^[ \t]*//; s/(R)/®/; s/(TM)/™/; s/@/\\n@/'")
    for line in result:lines() do
      text_t[n] = line
      n = n + 1
    end
    result:close()
  end
  text = text_t[1]
  displaytext(x,y,text,font,font_size,color)

  text_extents(text,font,font_size)
  text1center = (extents.width/2 + extents.x_bearing)
  text = text_t[2]
  text_extents(text,font,font_size)
  text2center = (extents.width/2 + extents.x_bearing)

  indent = text1center - text2center
  spacing = font_size
  x = x + indent
  y = y + spacing
  displaytext(x,y,text,font,font_size,color)
end
function ram_info(x,y)
  font = "inconsolata"
  font_size = 15
  color = color6
  if conky_start == 1 then
    result = io.popen("free --giga | sed '1d;3d' | awk '{print $2,\"GB\"}' ")
    for line in result:lines() do
      ram_size = line
    end
    result:close()
  end
  text = "Total RAM: " .. ram_size
  x = x + 50
  displaytext(x,y,text,font,font_size,color)
end
