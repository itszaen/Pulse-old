function heading(text,x,y,showring)
  showring = showring or 1
  font = "Inconsolata"
  font_size = 15
  color = color1
  size = 6

  displaytext(x,y,text,font,font_size,color)
  if showring == 1 then
    color = color5
    text_extents(text,font,font_size)
    cx = x
    cy = y + (extents.height/2 + extents.y_bearing)
    dx = x + extents.width+extents.x_bearing
    dy = cy
    radius = size + (-(extents.height/2 + extents.y_bearing))
    cairo_set_line_width(cr,1)
    cairo_set_source_rgba(cr,rgba(color))
    cairo_arc_negative(cr,cx,cy,radius,math.pi*3/2,math.pi*1/2)
    cairo_rel_line_to(cr,extents.width+extents.x_bearing,0)
    cairo_arc_negative(cr,dx,dy,radius,math.pi*1/2,math.pi*3/2)
    cairo_rel_line_to(cr,-(extents.width+extents.x_bearing),0)
    cairo_stroke(cr)
  end
  end
