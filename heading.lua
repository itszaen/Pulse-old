function heading1(x,y,text)
  font = "Inconsolata"
  font_size = 15
  color = color1
  size = 7

  displaytext(x,y,text,font,font_size,color)

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
function heading2(x,y,text)
  font = "Inconsolata"
  font_size = 15
  spacing = 4
  add = 1
  width = 1
  color = color1
  displaytext(x,y,text,font,font_size,color)
  text_extents(text,font,font_size)
  cairo_move_to(cr,x-add,y+spacing)
  cairo_rel_line_to(cr,add+extents.width+extents.x_bearing,0)
  cairo_set_line_width(cr,width)
  cairo_set_source_rgba(cr,rgba(color))
  cairo_stroke(cr)
end
function heading3(x,y,text)
  font = "Inconsolata"
  font_size = 15
  color = color1
  displaytext(x,y,text,font,font_size,color)
end
