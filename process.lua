-- the cpu will display the same as ram if interval is bigger than 1!
function cpuprocess(x,y)
  x = x
  y = y
  spacing = 1
  processfile(x,y,curdir .. "/.tmp/process_cpu",spacing,1)
end
function ramprocess(x,y)
  x = x
  y = y
  spacing = 1
  processfile(x,y,curdir .. "/.tmp/process_ram",spacing,1)
end
function processfile(x,y,file,spacing,interval)
  interval = interval
  font = "Inconsolata"
  font_slant = CAIRO_FONT_SLANT_NORMAL
  font_face  = CAIRO_FONT_WEIGHT_NORMAL
  font_size = 15
  spacing = spacing
  xpos = x
  ypos = y
  red = 0.6
  green = 0.6
  blue = 1
  alpha = 0.8

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
      ypos = ypos + font_size*spacing
      cairo_select_font_face (cr, font, font_slant, font_face)
      cairo_set_font_size (cr, font_size)
      cairo_set_source_rgba (cr, red,green,blue,alpha)
      cairo_move_to (cr,xpos,ypos)
      cairo_show_text (cr, file_content)
      cairo_stroke (cr)
      n = n+1
    end

end
