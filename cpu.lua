function cpuarc()
  --! Starts from the bottom
  interval = 1
  timer = (updates % interval)
  height = 440
  cpu = cpu
  cpu_height = cpu * (height/100.0)

  gap_out,radius_out = 300.0,300.0
  gap_in ,radius_in  = 295.0,290.0

  draw_cpu_arc(gap_out,radius_out) -- arc outside
  draw_cpu_arc_n(gap_in,radius_in) -- arc inside
  cpu_arc_lines()                  -- top & bottom Line
  cpu_arc_pattern()                -- filling gradation
  cairo_set_source(cr, pattern)
  cairo_fill(cr)
  cairo_stroke(cr)
end

--Functions
function draw_cpu_arc(gap,radius)
  range  =  2.0*((math.asin(height / (radius*2.0)))*180.0/math.pi) --91.1693 when radius is 350.0
  bottom = 180.0 - range/2.0 -- 134.4153 when radius is 350.0
  degree = 90 + math.acos((height/2 - cpu_height)/radius)*180.0/math.pi

  center_xpos = screen_x / 2 + radius - gap
  center_ypos = screen_y / 2

  start_angle = bottom * math.pi/180.0
  finish_angle   = degree * math.pi/180.0

  cairo_set_source_rgba (cr,1,1,1,1)
  cairo_arc (cr, center_xpos, center_ypos, radius, start_angle, finish_angle)
end
function draw_cpu_arc_n(gap,radius)
  range =  2*(math.asin(height / (radius*2)))*180/math.pi
  bottom = 180.0 - range/2.0
  degree = 90 + math.acos((height/2 - cpu_height)/radius)*180.0/math.pi

  center_xpos = screen_x / 2 + radius - gap
  center_ypos = screen_y / 2

  start_angle = degree * math.pi/180
  finish_angle   = bottom * math.pi/180
  -- the order here is important for filling to work properly

  cairo_set_source_rgba (cr,1,1,1,1)
  cairo_arc_negative(cr, center_xpos, center_ypos, radius, start_angle, finish_angle) --negative arc
end
function cpu_arc_lines()
  radius = radius
  top_start_xpos =  screen_x / 2 + radius_out - gap_out - radius_out
  top_start_ypos = screen_y/2 + height/2 - cpu_height
  top_end_xpos = screen_x / 2 + radius_in - gap_in - (math.sqrt(radius_in^2 - (height/2)^2))
  top_end_ypos = screen_y/2 + height/2 - cpu_height
  bottom_start_xpos = top_start_xpos
  bottom_start_ypos = screen_y / 2 + height/2
  bottom_end_xpos = top_end_xpos
  bottom_end_ypos = bottom_start_ypos
  draw_line(top_start_xpos,top_start_ypos,top_end_xpos,top_end_ypos)
  draw_line(bottom_start_xpos,bottom_start_ypos,bottom_end_xpos,bottom_end_ypos)
end
function draw_line(startx,starty, finishx,finishy)
  cairo_move_to (cr, startx , starty)
  cairo_line_to (cr, finishx , finishy)
end

function cpu_arc_pattern()
  pattern = cairo_pattern_create_linear (top_start_xpos , 290.0, top_start_xpos , 790.0)
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
