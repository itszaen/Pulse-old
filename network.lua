function network()
  down = downspeed
  up   = upspeed
  speedtest_interval = 720

  speedtest_timer = (updates % speedtest_interval)

  if internet_connected == 1 then
    if speedtest_timer == 0 or conky_start == 1 then
      os.execute("speedtest-cli --simple > /home/zaen/.config/conky/.tmp/speeds 2>&1")
      os.execute("cat /home/zaen/.config/conky/.tmp/speeds | sed -e 's/Ping/PNG/' -e 's/Download/DWN/' -e 's/Upload/UPL/' -e 's/$/    /' | tr '\n' ' '")
      speedtest_file = io.open("~/.config/conky/.tmp/speeds")
      speedtest_content_table = {}
      for line in speedtest_file:line() do
        speedtest_content = line
        table.insert(speedtest_content_table, speedtest_content)
      end
      speedtest_file:close()
      n = 1
      font = "Inconsolata"
      font_slant = CAIRO_FONT_SLANT_NORMAL
      font_face  = CAIRO_FONT_WEIGHT_NORMAL
      font_size = 15
      spacing = 3
      xpos = 50
      ypos = 50
      red,green,blue,alpha = 1,1,1,1

      for i, line in ipairs (speedtest_content_table) do
        speedtest_content = line
        xpos = xpos + font_size*spacing
        cairo_select_font_face (cr, font, font_slant, font_face)
        cairo_set_font_size (cr, font_size)
        cairo_set_source_rgba (cr, red,green,blue,alpha)
        cairo_move_to (cr,xpos,ypos)
        print(xpos)
        cairo_show_text (cr, speedtest_content)
        n = n+1
      end
    end
  else
    font = "Inconsolata"
    font_slant = CAIRO_FONT_SLANT_NORMAL
    font_face = CAIRO_FONT_WEIGHT_NORMAL
    font_size = 18
    red, green, blue = 1,1,1
    alpha = 1
    xpos = 200
    ypos = 200
    text = "NOT CONNECTED"
    cairo_select_font_face (cr, font, font_slant, font_face)
    cairo_set_font_size (cr, font_size)
    cairo_set_source_rgba (cr, red, green, blue, alpha)
    cairo_move_to (cr, xpos, ypos)
    cairo_show_text (cr, text)
    cairo_stroke (cr)
  end

end
