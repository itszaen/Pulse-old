function clock()
  size = center
  inner = 50
  digital_t = 0
  if digital_t == 1 then
    digital_date()
    digital_time()
    innerline()
  else end
  analog_time()
  watch_dial()
  archlogo()
  archname()
end
function archname()
  font = "Z003"
  font_size = center/16.5
  x = 0
  y = -85
  red = 0.6
  green = 0.6
  blue = 1.0
  alpha = 0.6
  font_slant = CAIRO_FONT_SLANT_NORMAL
  font_weight = CAIRO_FONT_WEIGHT_NORMAL
  text = "Arch Linux"
  cairo_select_font_face(cr,font,font_slant,font_face)
  cairo_set_font_size(cr,font_size)
  cairo_set_source_rgba(cr,red,green,blue,alpha)
  extents = cairo_text_extents_t:create()
  tolua.takeownership(extents)
  cairo_text_extents(cr,text,extents)
  x = centerx - (extents.width / 2 + extents.x_bearing) + x
  y = centery - (extents.height/ 2 + extents.y_bearing) + y
  cairo_move_to(cr,x,y)
  cairo_show_text(cr,text)
  cairo_stroke(cr)
end
function archlogo()
  original = 200
  size = 0.30  -- 1 = 200x200
  x = 0
  y = -125
  x = centerx + x
  y = centery - original*size/2 + y
  pattern = cairo_pattern_create_rgba(0.6,0.6,1.0,0.8)
  cairo_set_source(cr,pattern)
  cairo_new_path(cr)
  cairo_move_to(cr,x,y)
  cairo_rel_curve_to(cr,-7.398438*size,18.136719*size,-11.859375*size,29.996094*size,-20.09375*size,47.59375*size)
  cairo_rel_curve_to(cr,5.050781*size,5.351562*size,11.246094*size,11.585938*size,21.3125*size,18.625*size)
  cairo_rel_curve_to(cr,-10.820312*size,-4.453125*size,-18.203125*size,-8.921875*size,-23.71875*size,-13.5625*size)
  cairo_rel_curve_to(cr,-10.539062*size,21.992188*size,-27.050781*size,53.320312*size,-60.5625*size,113.53125*size)
  cairo_rel_curve_to(cr,26.335938*size,-15.207031*size,46.753906*size,-24.578125*size,65.78125*size,-28.15625*size)
  cairo_rel_curve_to(cr,-0.816406*size,-3.515625*size,-1.28125*size,-7.316406*size,-1.25*size,-11.28125*size)
  cairo_rel_line_to(cr,0.03125*size,-0.84375*size)
  cairo_rel_curve_to(cr,0.417969*size,-16.875*size,9.195312*size,-29.851562*size,19.59375*size,-28.96875*size)
  cairo_rel_curve_to(cr,10.398438*size,0.882812*size,18.480469*size,15.28125*size,18.0625*size,32.15625*size)
  cairo_rel_curve_to(cr,-0.078125*size,3.175781*size,-0.4375*size,6.230469*size,-1.0625*size,9.0625*size)
  cairo_rel_curve_to(cr,18.820312*size,3.683594*size,39.019531*size,13.03125*size,65*size,28.03125*size)
  cairo_rel_curve_to(cr,-5.121094*size,-9.433594*size,-9.695312*size,-17.933594*size,-14.0625*size,-26.03125*size)
  cairo_rel_curve_to(cr,-6.878906*size,-5.332031*size,-14.054688*size,-12.269531*size,-28.6875*size,-19.78125*size)
  cairo_rel_curve_to(cr,10.058594*size,2.613281*size,17.261719*size,5.628906*size,22.875*size,9*size)
  cairo_rel_curve_to(cr,-44.398438*size,-82.660156*size,-47.992188*size,-93.644531*size,-63.21875*size,-129.375*size)
  cairo_move_to(cr,x,y)
  cairo_close_path(cr)
  cairo_set_fill_rule(cr,CAIRO_FILL_RULE_EVEN_ODD)
  cairo_fill(cr)

end
function analog_time()
  hour_degree = hours12*360/12 + minutes*360/720 + seconds*360/43200 -90
  minute_degree = minutes*360/60 + seconds*360/3600 -90
  second_degree = seconds*360/60 -90
  if digital_t == 1 then
    hour_length = 0.7
    minute_length = 0.9
    second_length = 1.0
  else
    hour_length = 0.5
    minute_length = 0.8
    second_length = 1.0
  end
  watch_hand(hour_degree,5,hour_length)
  watch_hand(minute_degree,3,minute_length)
  watch_hand(second_degree,1,second_length)

end
function watch_hand(degree,width,ratio)
  red = 0.68
  green = 0.68
  blue = 1.0
  alpha = 0.8
  if digital_t ==1 then
    sx = centerx + math.cos(degree*math.pi/180)*inner
    sy = centery + math.sin(degree*math.pi/180)*inner
  fx = sx + ratio*(math.cos(degree*math.pi/180)*(size/2-25-inner))
  fy = sy + ratio*(math.sin(degree*math.pi/180)*(size/2-25-inner))
  else
    sx = centerx
    sy = centery
    fx = sx + ratio*(math.cos(degree*math.pi/180)*(size/2-25))
    fy = sy + ratio*(math.sin(degree*math.pi/180)*(size/2-25))
  end
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
  font_size = inner/4
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
  x1 = centerx - (extents.width/2 + extents.x_bearing)
  y1 = centery - font_size*offset - (extents.height/2 + extents.y_bearing)
  cairo_text_extents (cr,text2,extents)
  x2 = centerx - (extents.width/2 + extents.x_bearing)
  y2 = centery + font_size*offset - (extents.height/2 + extents.y_bearing)

  cairo_move_to (cr,x1,y1)
  cairo_show_text (cr,text1)
  cairo_move_to (cr,x2,y2)
  cairo_show_text (cr,text2)
  cairo_stroke(cr)

end
function digital_time()
  font="Liberation Serif"
  font_size=inner/2
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
