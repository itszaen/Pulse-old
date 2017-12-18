function cpuarc()
  --! Starts from the bottom
  interval = 1
  timer = (updates % interval)
  cut   = 0
  height = center
  cpu = cpu
  cpu_height = cpu * (height/100.0)
  cut_height = cut * (cpu/100.0)

  gap_out,radius_out = 315.0,280.0
  gap_in ,radius_in  = 310.0,275.0

  cpu_arc_background(gap_out,radius_out,cut)
  cpu_arc_background_n(gap_in,radius_in,cut)
  cpu_arc_background_lines(cut)
  cairo_set_source_rgba(cr,0.34,0.34,0.5,0.5)
  cairo_fill(cr)
  cairo_stroke(cr)
  draw_cpu_arc(gap_out,radius_out,cut) -- arc outside
  draw_cpu_arc_n(gap_in,radius_in,cut) -- arc inside
  cpu_arc_lines(cut)                  -- top & bottom Line
  cpu_arc_pattern(cut)                -- filling gradation
  cairo_set_source(cr, pattern)
  cairo_fill(cr)
  cairo_stroke(cr)
  cpu_indicator(660,screen_y/2,1)
end

--Functions
function cpu_arc_background(gap,radius,cut)
  cut = cut or 0
  range  = (math.asin((height/2.0 - cut) / radius))*180.0/math.pi --91.1693 when radius is 350.0
  bottom = 180.0 - range                                            -- 134.4153 when radius is 350.0
  degree = 180.0  + range

  center_xpos = screen_x / 2 + radius - gap
  center_ypos = screen_y / 2

  start_angle = bottom * math.pi/180.0
  finish_angle   = degree * math.pi/180.0

  cairo_set_source_rgba (cr,1,1,1,1)
  cairo_arc (cr, center_xpos, center_ypos, radius, start_angle, finish_angle)
end
function cpu_arc_background_n (gap,radius,cut)
  cut = cut or 0
  range =  (math.asin((height/2.0 - cut) / radius))*180/math.pi
  bottom = 180.0 - range
  degree = 180.0  + range

  center_xpos = screen_x / 2 + radius - gap
  center_ypos = screen_y / 2

  start_angle  = degree * math.pi/180
  finish_angle = bottom * math.pi/180
  -- the order here is important for filling to work properly

  cairo_set_source_rgba (cr,1,1,1,1)
  cairo_arc_negative(cr, center_xpos, center_ypos, radius, start_angle, finish_angle) --negative arc
end

function cpu_arc_background_lines(cut)
  cut = cut or 0
  top_start_xpos =  screen_x / 2 + radius_out - gap_out - radius_out
  top_start_ypos = screen_y/2 - height/2 + cut
  top_end_xpos = screen_x / 2 + radius_in - gap_in - (math.sqrt(radius_in^2 - (height/2)^2))
  top_end_ypos = screen_y/2 - height/2 + cut
  bottom_start_xpos = top_start_xpos
  bottom_start_ypos = screen_y / 2 + height/2 - cut
  bottom_end_xpos = top_end_xpos
  bottom_end_ypos = bottom_start_ypos
  draw_line(top_start_xpos,top_start_ypos,top_end_xpos,top_end_ypos)
  draw_line(bottom_start_xpos,bottom_start_ypos,bottom_end_xpos,bottom_end_ypos)
end

function draw_cpu_arc(gap,radius,cut)
  cut = cut or 0
  range  = 2.0*((math.asin((height/2.0 - cut) / radius))*180.0/math.pi) --91.1693 when radius is 350.0
  bottom = 180.0 - range/2.0                                            -- 134.4153 when radius is 350.0
  degree = 90 + math.acos((height/2.0 - cpu_height + cut_height)/radius)*180.0/math.pi

  center_xpos = screen_x / 2 + radius - gap
  center_ypos = screen_y / 2

  start_angle = bottom * math.pi/180.0
  finish_angle   = degree * math.pi/180.0

  cairo_set_source_rgba (cr,1,1,1,1)
  cairo_arc (cr, center_xpos, center_ypos, radius, start_angle, finish_angle)
end
function draw_cpu_arc_n(gap,radius,cut)
  cut = cut or 0
  range =  2.0*(math.asin((height/2.0 - cut) / radius))*180/math.pi
  bottom = 180.0 - range/2.0
  degree = 90 + math.acos((height/2.0 - cpu_height + cut_height)/radius)*180.0/math.pi

  center_xpos = screen_x / 2 + radius - gap
  center_ypos = screen_y / 2

  start_angle = degree * math.pi/180
  finish_angle   = bottom * math.pi/180
  -- the order here is important for filling to work properly

  cairo_set_source_rgba (cr,1,1,1,1)
  cairo_arc_negative(cr, center_xpos, center_ypos, radius, start_angle, finish_angle) --negative arc
end

function cpu_arc_lines(cut)
  cut = cut or 0
  top_start_xpos =  screen_x / 2 + radius_out - gap_out - radius_out
  top_start_ypos = screen_y/2 + height/2 - cpu_height + cut_height
  top_end_xpos = screen_x / 2 + radius_in - gap_in - (math.sqrt(radius_in^2 - (height/2)^2))
  top_end_ypos = screen_y/2 + height/2 - cpu_height + cut_height
  bottom_start_xpos = top_start_xpos
  bottom_start_ypos = screen_y / 2 + height/2 - cut
  bottom_end_xpos = top_end_xpos
  bottom_end_ypos = bottom_start_ypos
  cairo_set_line_width (cr,1)
  draw_line(top_start_xpos,top_start_ypos,top_end_xpos,top_end_ypos)
  draw_line(bottom_start_xpos,bottom_start_ypos,bottom_end_xpos,bottom_end_ypos)
end
function draw_line(startx,starty, finishx,finishy)
  cairo_move_to (cr, startx , starty)
  cairo_line_to (cr, finishx , finishy)
end

function cpu_arc_pattern(cut)
  cut = cut or 0
  pattern = cairo_pattern_create_linear (top_start_xpos , 290.0+cut, top_start_xpos , 790.0-cut)
  pattern1_red, pattern1_green, pattern1_blue = 1,0,0 --red
  pattern1_alpha = 1
  pattern2_red, pattern2_green, pattern2_blue = 0,0,1 --blue
  pattern2_alpha = 1
  pattern3_red, pattern3_green, pattern3_blue = 0,1,0 --green
  pattern3_alpha = 1
  pattern4_red, pattern4_green, pattern4_blue = 1,1,0 --yellow
  pattern4_alpha = 1

  cairo_pattern_add_color_stop_rgba (pattern, 0,   pattern1_red,pattern1_green,pattern1_blue,pattern1_alpha)
  cairo_pattern_add_color_stop_rgba (pattern, 0.5, pattern4_red,pattern4_green,pattern4_blue,pattern4_alpha)
  cairo_pattern_add_color_stop_rgba (pattern, 0.8, pattern3_red,pattern3_green,pattern3_blue,pattern3_alpha)
  cairo_pattern_add_color_stop_rgba (pattern, 1,   pattern2_red,pattern2_green,pattern2_blue,pattern2_alpha)
end
function cpu_indicator(x,y,spacing)
  x = x
  y = y
  spacing = spacing
  font = "Inconsolata"
  font_slant = CAIRO_FONT_SLANT_NORMAL
  font_face  = CAIRO_FONT_WEIGHT_NORMAL
  font_size  = 15
  text1 = "CPU"
  text2 = cpu .. "%"
  red,green,blue = 0.68,0.68,1
  alpha = 0.8
  cairo_select_font_face (cr,font,font_slant,font_face,font_size)
  cairo_set_font_size (cr,font_size)
  cairo_set_source_rgba (cr,red,green,blue,alpha)
  cairo_move_to (cr,x,y)
  cairo_show_text (cr,text1)
  cairo_move_to (cr,x,y+spacing*font_size)
  cairo_show_text (cr,text2)
  cairo_stroke(cr)
end
