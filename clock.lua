function clock()
  size = center
  inner = size/2 -140
  digital_date()
  digital_time()
  analog_time()
  watch_dial()
end
function analog_time()
  hour_degree = hours*360/24 -90
  minute_degree = minutes*360/60 -90
  second_degree = seconds*360/60 -90
  watch_hand(hour_degree,5,0.7)
  watch_hand(minute_degree,3,0.9)
  watch_hand(second_degree,1,1)

end
function watch_hand(degree,width,ratio)
  red = 0.68
  green = 0.68
  blue = 1.0
  alpha = 0.8
  sx = centerx + math.cos(degree*math.pi/180)*inner
  sy = centery + math.sin(degree*math.pi/180)*inner
  fx = sx + ratio*(math.cos(degree*math.pi/180)*(size/2-25-inner))
  fy = sy + ratio*(math.sin(degree*math.pi/180)*(size/2-25-inner))
  cairo_set_line_width (cr,width)
  cairo_set_source_rgba (cr,red,green,blue,alpha)
  cairo_move_to(cr,sx,sy)
  cairo_line_to(cr,fx,fy)
  cairo_stroke(cr)

end
function watch_dial()
  thick = 6
  normal = 3
  thin = 1
  for i=0,359,6 do
    if i%90 == 0 then
      width = thick
      alpha = 0.8
    elseif i%30 == 0 then
      width = normal
      alpha = 0.6
    else
      width = thin
      alpha = 0.3
    end
    watch_dial_line(i,width,alpha)
  end
  innerline()
end
function innerline()
  width = 5
  red = 0.68
  green = 0.68
  blue = 1.0
  alpha = 0.1
  radius = inner
  cairo_set_line_width (cr,width)
  cairo_set_source_rgba(cr,red,green,blue,alpha)
  cairo_arc (cr,screen_x/2,screen_y/2,radius,0,2*math.pi)
  cairo_stroke(cr)
end
function watch_dial_line(degree,width,alpha)
  length = 25
  hand = size/2 - length
  red   = 0.68
  green = 0.68
  blue  = 1.0
--  alpha = 0.8
  sx = screen_x/2 + math.cos(degree*math.pi/180)*hand
  sy = screen_y/2 + math.sin(degree*math.pi/180)*hand
  fx = screen_x/2 + math.cos(degree*math.pi/180)*(hand+length)
  fy = screen_y/2 + math.sin(degree*math.pi/180)*(hand+length)

  cairo_set_line_width (cr,width)
  cairo_set_source_rgba(cr,red,green,blue,alpha)
  cairo_move_to(cr,sx,sy)
  cairo_line_to(cr,fx,fy)
  cairo_stroke(cr)
end
function digital_date()
  font="Liberation Serif"
  font_size = 20
  offset = 1.8
  red = 0.68
  green = 0.68
  blue = 1.0
  alpha = 0.8
  font_slant = CAIRO_FONT_SLANT_NORMAL
  font_weight = CAIRO_FONT_WEIGHT_NORMAL
  text1 = monthn .. " " .. year
  text2 = weekdayn .. " " .. day

  cairo_select_font_face (cr,font,font_slant,font_face)
  cairo_set_font_size (cr,font_size)
  cairo_set_source_rgba (cr,red,green,blue,alpha)
  extents = cairo_text_extents_t:create()
  tolua.takeownership(extents)
  cairo_text_extents (cr,text1,extents)
  x1 = screen_x/2 - (extents.width/2 + extents.x_bearing)
  y1 = screen_y/2 - font_size*offset - (extents.height/2 + extents.y_bearing)
  cairo_text_extents (cr,text2,extents)
  x2 = screen_x/2 - (extents.width/2 + extents.x_bearing)
  y2 = screen_y/2 + font_size*offset - (extents.height/2 + extents.y_bearing)

  cairo_move_to (cr,x1,y1)
  cairo_show_text (cr,text1)
  cairo_move_to (cr,x2,y2)
  cairo_show_text (cr,text2)
  cairo_stroke(cr)

end
function digital_time()
  font="Liberation Serif"
  font_size=40
  hours = hours
  minutes = minutes
  seconds = seconds
  red   = 0.68
  green = 0.68
  blue  = 1.0
  alpha = 0.8

  font_slant = CAIRO_FONT_SLANT_NORMAL
  font_face = CAIRO_FONT_WEIGHT_NORMAL

  text = hours .. ":" .. minutes .. ":" .. seconds
--[[
  if hours > 13 then
    text = hours-13 .. ":" .. minutes .. " PM"
  else
    text = hours .. ":" .. minutes .. " AM"
  end
]]

  cairo_select_font_face (cr,font,font_slant,font_face)
  cairo_set_font_size (cr,font_size)
  cairo_set_source_rgba (cr,red,green,blue,alpha)
  extents=cairo_text_extents_t:create()
  tolua.takeownership(extents)
  cairo_text_extents (cr,text,extents)
  xpos = screen_x/2 - (extents.width/2 + extents.x_bearing)
  ypos = screen_y/2 - (extents.height/2 + extents.y_bearing)
  cairo_move_to (cr, xpos, ypos)
  cairo_show_text (cr, text)
  cairo_stroke(cr)
end
