function network()
  down = downspeed
  up   = upspeed
  speedtest_interval = 30
  font = "Inconsolata"
  font_slant = CAIRO_FONT_SLANT_NORMAL
  font_face  = CAIRO_FONT_WEIGHT_NORMAL
  font_size = 15
  spacing = 10.5
  xpos = -50
  ypos = 340
  red = 0.6
  green = 0.6
  blue = 1
  alpha = 1

  speedtest_timer = (updates % speedtest_interval)
  if internet_connected_wlp2s0 == 1 or internet_connected_enp4s0 == 1 then
      if speedtest_timer == 0 or conky_start == 1 then
      speedtest_file = io.open(curdir .. "/.tmp/speeds")
      speedtest_content_table = {}
      for line in speedtest_file:lines() do
        speedtest_content = line
        table.insert(speedtest_content_table, speedtest_content)
      end
      speedtest_file:close()
    end

    n = 1
    for i, line in ipairs (speedtest_content_table) do
      speedtest_content = line
      xpos = xpos + font_size*spacing
      cairo_select_font_face (cr, font, font_slant, font_face)
      cairo_set_font_size (cr, font_size)
      cairo_set_source_rgba (cr, red,green,blue,alpha)
      cairo_move_to (cr,xpos,ypos)
      cairo_show_text (cr, speedtest_content)
      cairo_stroke (cr)
      n = n+1
    end

    --download speed
    display_speed("DWN SPD",downspeed,600,135,1.5)
    display_speed("UPL SPD",upspeed  ,600,255,1.5)
  else
    font = "Inconsolata"
    font_slant = CAIRO_FONT_SLANT_NORMAL
    font_face = CAIRO_FONT_WEIGHT_NORMAL
    font_size = 30
    red, green, blue = 0.68,0.68,1
    alpha = 0.6
    xpos = 220
    ypos = 250
    text = "INTERNET DISCONNECTED"
    cairo_select_font_face (cr, font, font_slant, font_face)
    cairo_set_font_size (cr, font_size)
    cairo_set_source_rgba (cr, red, green, blue, alpha)
    cairo_move_to (cr, xpos, ypos)
    cairo_show_text (cr, text)
    cairo_stroke (cr)
  end

end

function display_speed(text,speed,x,y,spacing)
  text2 = speed_convert_s(speed)
  xpos = x
  ypos = y
  font = "Inconsolata"
  font_slant = CAIRO_FONT_SLANT_NORMAL
  font_face  = CAIRO_FONT_WEIGHT_NORMAL
  font_size = 20
  red = 0.68
  green = 0.68
  blue = 1
  alpha = 0.8
  spacing = spacing
  cairo_select_font_face (cr, font, font_slant, font_face)
  cairo_set_font_size (cr,font_size)
  cairo_set_source_rgba (cr,red, green,blue,alpha)
  cairo_move_to (cr, xpos, ypos)
  cairo_show_text(cr,text)
  cairo_move_to (cr, xpos, ypos+font_size*spacing)
  cairo_show_text(cr,text2)
  cairo_stroke(cr)
end

function speed_convert_s (speed)
  if tonumber(speed) < 100.0 then
    speed = round_float(speed,1)
    s = tostring(speed) .. " KiB"
    return s
  elseif tonumber(speed) < 100000.0 then
    speed = speed / 1000.0
    speed = round_float(speed,1)
    s = tostring(speed) .. " MiB"
    return s
  elseif tonumber(speed) < 100000000.0 then
    speed = speed / 1000000.0
    speed = round_float(speed,1)
    s = tostring(speed) .. " GiB"
    return s
  else
    speed = speed / 1000000.0
    speed = round_float(speed,1)
    s = tostring(speed) .. "GiB"
  end
end

function round_float(num, numDecimalPlaces) --string
  rounded = string.format("%." .. (numDecimalPlaces or 0) .. "f", num) -- string
  return rounded
end
