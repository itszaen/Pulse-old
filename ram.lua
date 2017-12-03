function ramarc()
  --! Starts from the top
  interval = 1
  timer    = (updates % interval)
  height   = 440
  ram      = memory
  ram_height = ram * (height/100.0)

  gap_out,radius_out = 315.0,280.0
  gap_in ,radius_in  = 310.0,275.0
  cut = 0

  ram_arc_background(gap_in,radius_in,cut)
  ram_arc_background_n(gap_out,radius_out,cut)
  ram_arc_background_lines(cut)
  cairo_set_source_rgba (cr,0.34,0.34,0.5,0.5)
  cairo_fill(cr)
  cairo_stroke(cr)
  draw_ram_arc(gap_in,radius_in,cut)     -- arc outside
  draw_ram_arc_n(gap_out,radius_out,cut) -- arc inside
  ram_arc_lines(cut)                    -- top & bottom Line
  ram_arc_pattern(cut)                  -- filling gradation
  cairo_set_source(cr, pattern)
  cairo_fill(cr)
  cairo_stroke(cr)
  ran_indicator(1230,screen_y/2,1)
end
-- Functions
function ram_arc_background(gap,radius,cut)
  cut = cut or 0
  range = (math.asin((height/2.0 - cut) / radius))*180.0/math.pi
  top = 360.0 - range
  degree = 360.0 + range

  start_angle = top *math.pi/180
  finish_angle = degree *math.pi/180

  center_xpos = screen_x / 2 - radius + gap
  center_ypos = screen_y / 2

  cairo_set_source_rgba (cr,1,1,1,1)
  cairo_arc(cr, center_xpos, center_ypos, radius, start_angle, finish_angle)
end
function ram_arc_background_n(gap,radius,cut)
  cut = cut or 0
  range = (math.asin((height/2.0 - cut) / radius))*180.0/math.pi
  top = 360.0 - range
  degree = 360.0 + range

  start_angle = degree *math.pi/180
  finish_angle = top   *math.pi/180

  center_xpos = screen_x / 2 - radius + gap
  center_ypos = screen_y / 2

  cairo_set_source_rgba (cr,1,1,1,1)
  cairo_arc_negative(cr, center_xpos, center_ypos, radius, start_angle, finish_angle)
end
function ram_arc_background_lines(cut)
  cut = cut or 0
  top_start_xpos = screen_x /2 - radius_in + gap_in + (math.sqrt(radius_in^2 - (height/2)^2))
  top_start_ypos = screen_y /2 - height/2 + cut
  top_end_xpos   = screen_x /2 + gap_out
  top_end_ypos = top_start_ypos
  bottom_start_xpos = top_start_xpos
  bottom_start_ypos = screen_y/2 + height/2 - cut
  bottom_end_xpos = top_end_xpos
  bottom_end_ypos = bottom_start_ypos
  draw_line(top_start_xpos,top_start_ypos,top_end_xpos,top_end_ypos)
  draw_line(bottom_start_xpos, bottom_start_ypos,bottom_end_xpos,bottom_end_ypos)
end

function draw_ram_arc(gap,radius,cut)
  cut = cut or 0
  range = (math.asin((height/2.0 - cut) / radius))*180.0/math.pi
  top = 360.0 - range
  degree = 270.0 + math.acos((height/2.0 - ram_height + cut)/radius)*180.0/math.pi

  start_angle = top *math.pi/180
  finish_angle = degree *math.pi/180

  center_xpos = screen_x / 2 - radius + gap
  center_ypos = screen_y / 2

  cairo_set_source_rgba (cr,1,1,1,1)
  cairo_arc(cr, center_xpos, center_ypos, radius, start_angle, finish_angle)
end
function draw_ram_arc_n(gap,radius,cut)
  cut = cut or 0
  range = (math.asin((height/2.0 - cut) / radius))*180.0/math.pi
  top = 360.0 - range
  degree = 270.0 + math.acos((height/2.0 - ram_height + cut)/radius)*180.0/math.pi

  start_angle = degree *math.pi/180
  finish_angle = top   *math.pi/180

  center_xpos = screen_x / 2 - radius + gap
  center_ypos = screen_y / 2

  cairo_set_source_rgba (cr,1,1,1,1)
  cairo_arc_negative(cr, center_xpos, center_ypos, radius, start_angle, finish_angle)
end
function ram_arc_lines(cut)
  cut = cut or 0
  top_start_xpos = screen_x /2 - radius_in + gap_in + (math.sqrt(radius_in^2 - (height/2)^2))
  top_start_ypos = screen_y /2 - height/2 + cut
  top_end_xpos   = screen_x /2 + gap_out
  top_end_ypos = top_start_ypos
  bottom_start_xpos = top_start_xpos
  bottom_start_ypos = screen_y/2 - height/2 + ram_height
  bottom_end_xpos = top_end_xpos
  bottom_end_ypos = bottom_start_ypos
  draw_line(top_start_xpos,top_start_ypos,top_end_xpos,top_end_ypos)
  draw_line(bottom_start_xpos, bottom_start_ypos,bottom_end_xpos,bottom_end_ypos)
end
function draw_line(startx,starty,finishx,finishy)
  cairo_move_to (cr, startx, starty)
  cairo_line_to (cr, finishx, finishy)
end
function ram_arc_pattern(cut)
  cut = cut or 0
  pattern = cairo_pattern_create_linear (bottom_start_xpos , 290.0+cut, bottom_start_xpos , 790.0-cut)

  pattern1_red, pattern1_green, pattern1_blue = 1,0,0 --red
  pattern1_alpha = 1
  pattern2_red, pattern2_green, pattern2_blue = 0,0,1 --blue
  pattern2_alpha = 1
  pattern3_red, pattern3_green, pattern3_blue = 0,1,0 --green
  pattern3_alpha = 1
  pattern4_red, pattern4_green, pattern4_blue = 1,1,0 --yellow
  pattern4_alpha = 1

  cairo_pattern_add_color_stop_rgba (pattern, 1,   pattern1_red,pattern1_green,pattern1_blue,pattern1_alpha)
  cairo_pattern_add_color_stop_rgba (pattern, 0.8, pattern4_red,pattern4_green,pattern4_blue,pattern4_alpha)
  cairo_pattern_add_color_stop_rgba (pattern, 0.5, pattern3_red,pattern3_green,pattern3_blue,pattern3_alpha)
  cairo_pattern_add_color_stop_rgba (pattern, 0,   pattern2_red,pattern2_green,pattern2_blue,pattern2_alpha)
end
function ran_indicator(x,y,spacing)
  x = x
  y = y
  spacing = spacing
  font = "Inconsolata"
  font_slant = CAIRO_FONT_SLANT_NORMAL
  font_face  = CAIRO_FONT_WEIGHT_NORMAL
  font_size  = 15
  text1 = "ram"
  text2 = ram .. "%"
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
