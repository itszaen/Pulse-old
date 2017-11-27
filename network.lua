function network()
  down = downspeed
  up   = upspeed
  interval = 1

  timer = (updates % interval)
  if internet_connected == 1 then

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
  end
  cairo_select_font_face (cr, font, font_slant, font_face)
  cairo_set_font_size (cr, font_size)
  cairo_set_source_rgba (cr, red, green, blue, alpha)
  cairo_move_to (cr, xpos, ypos)
  cairo_show_text (cr, text)
  cairo_stroke (cr)

end
