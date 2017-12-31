function svg2luacairo(filepath)
  file = assert(io.popen(curdir.."/svg2cairoxml ".. filepath))
  data = ""
  for line in file:lines() do
    s1,f1 = line:find("<path>")
    if s1 ~= nil then
      start = f1 + 1
      s2,f2 = line:find("</path>")
      finish = s2 - 1
      data = data .. line:sub(start,finish)
    end
  end
  file:close()
  data = trim(data)
  item_t = {} -- important
  item_number_t = {}
  for item in data:gmatch("%S+") do
    if item == "m" or item == "c" or item == "l" or item == "h" then
      local row = {}
      table.insert(row,item)
      table.insert(row,item_number_t)
      table.insert(item_t,row)
      item_number_t = {}
    else
      table.insert(item_number_t,item)
    end
  end
  return item_t
end

function draw_cairo(x,y,file,size,original,color)
  cairo_t = svg2luacairo(file)
  scale = size/original
  pattern = cairo_pattern_create_rgba(rgba(color))
  cairo_set_source(cr,pattern)
  cairo_new_path(cr)
  local n = table.getn(cairo_t)
  for i=1,n do
    row = cairo_t[i]
    if row[1] == "m" then
      cairo_move_to(cr,x+row[2][1]*scale,y+row[2][2]*scale)
    elseif row[1] == "l" then
      cairo_line_to(cr,x+row[2][1]*scale,y+row[2][2]*scale)
    elseif row[1] == "c" then
      cairo_curve_to(cr,x+row[2][1]*scale,y+row[2][2]*scale,
                        x+row[2][3]*scale,y+row[2][4]*scale,
                        x+row[2][5]*scale,y+row[2][6]*scale)
    elseif row[1] == "h" then
      cairo_close_path(cr)
    else
      return "error"
    end
  end
  cairo_fill(cr)
end

function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end
