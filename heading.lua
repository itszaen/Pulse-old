function heading(text,x,y)
  font = "Inconsolata"
  font_slant = CAIRO_FONT_SLANT_NORMAL
  font_face  = CAIRO_FONT_WEIGHT_NORMAL
  font_size = 15
  red, green, blue = 0.68, 0.68, 1
  alpha = 1
  xpos = x
  ypos = y
  cairo_select_font_face (cr,font,font_slant, font_face)
  cairo_set_font_size (cr, font_size)
  cairo_set_source_rgba (cr,red,green,blue,alpha)
  cairo_move_to (cr,xpos,ypos)
  cairo_show_text (cr,text)
  cairo_stroke(cr)
end
