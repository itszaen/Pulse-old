-- the cpu will display the same as ram if interval is bigger than 1!
function cpuprocess(x,y)
  spacing = 1
  processfile(x,y,curdir .. "/.tmp/process_cpu",spacing,1)
end
function ramprocess(x,y)
  spacing = 1
  processfile(x,y,curdir .. "/.tmp/process_ram",spacing,1)
end
function processfile(x,y,file,spacing,interval)
  font = "Inconsolata"
  font_size = 15
  color = color2

  timer = (updates % interval)
  if timer == 0 or conky_start == 1 then
      file = io.open(file)
      file_content_table = {}
      for line in file:lines() do
        file_content = line
        table.insert(file_content_table, file_content)
      end
      file:close()
    end
    n = 1
    for i, line in ipairs (file_content_table) do
      file_content = line
      y = y + font_size*spacing
      displaytext(x,y,file_content,font,font_size,color)
      n = n+1
    end

end
