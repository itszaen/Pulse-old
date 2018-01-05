function ramarc()
  --! Starts from the top
  interval = 1
  timer    = (updates % interval)
  size     = 0.75
  height   = center * size
  ram      = memory
  ram_height = ram * (height/100.0)
  bgcolor  = {0.34,0.34,0.5,0.5}

  offset_out,radius_out = 315.0,250.0
  offset_in ,radius_in  = 310.0,250.0
  offset_indicator = 275

  ram_arc_background(offset_in,radius_in)
  ram_arc_background_n(offset_out,radius_out)
  ram_arc_background_lines()
  cairo_close_path(cr)
  cairo_set_source_rgba (cr,rgba(bgcolor))
  cairo_fill(cr)
  draw_ram_arc(offset_in,radius_in)     -- arc outside
  draw_ram_arc_n(offset_out,radius_out) -- arc inside
  ram_arc_lines()                    -- top & bottom Line
  ram_arc_pattern()                  -- filling gradation
  cairo_close_path(cr)
  cairo_set_source(cr, pattern)
  cairo_fill(cr)
  ram_indicator(centerx+offset_indicator,centery,1)
end
-- Functions
function ram_arc_background(offset,radius)
  range  = (math.asin((height/2.0) / radius))*180.0/math.pi
  top    = 360.0 - range
  bottom = 360.0 + range
  local color = {1.0,1.0,1.0,1.0}

  center_xpos = centerx - radius + offset
  center_ypos = centery

  start_angle  = top    *math.pi/180.0
  finish_angle = bottom *math.pi/180.0

  cairo_set_source_rgba (cr,rgba(color))
  cairo_arc(cr, center_xpos, center_ypos, radius, start_angle, finish_angle)
end
function ram_arc_background_n(offset,radius)
  range  = (math.asin((height/2.0) / radius))*180.0/math.pi
  top    = 360.0 - range
  bottom = 360.0 + range
  local color = {1.0,1.0,1.0,1.0}

  start_angle  = bottom *math.pi/180
  finish_angle = top    *math.pi/180

  center_xpos = centerx - radius + offset
  center_ypos = centery

  cairo_set_source_rgba (cr,rgba(color))
  cairo_arc_negative(cr, center_xpos, center_ypos, radius, start_angle, finish_angle)
end
function ram_arc_background_lines()
  top_sx = centerx - radius_in + offset_in + (math.sqrt(radius_in^2 - (height/2)^2))
  top_sy = centery - height/2
  top_fx   = centerx + offset_out
  top_fy = top_sy
  bottom_sx = top_sx
  bottom_sy = centery /2 + height/2
  bottom_fx = top_fx
  bottom_fy = bottom_sy
  draw_line(top_sx,top_sy,top_fx,top_fy)
  draw_line(bottom_sx, bottom_sy,bottom_fx,bottom_fy)
end

function draw_ram_arc(offset,radius)
  range  = (math.asin((height/2.0) / radius))*180.0/math.pi
  top    = 360.0 - range
  bottom = 360 - (90 - math.acos((height/2.0 - ram_height)/radius)*180.0/math.pi)
  color = {1.0,1.0,1.0,1.0}

  center_xpos = centerx - radius + offset
  center_ypos = centery

  start_angle  = top    *math.pi/180
  finish_angle = bottom *math.pi/180

  cairo_set_source_rgba (cr,rgba(color))
  cairo_arc(cr, center_xpos, center_ypos, radius, start_angle, finish_angle)
end
function draw_ram_arc_n(offset,radius)
  range  = (math.asin((height/2.0) / radius))*180.0/math.pi
  top    = 360.0 - range
  bottom = 360.0 - (90.0 - math.acos((height/2.0 - ram_height)/radius)*180.0/math.pi)
  color = {1.0,1.0,1.0,1.0}

  center_xpos = centerx - radius + offset
  center_ypos = centery

  start_angle  = bottom *math.pi/180
  finish_angle = top   *math.pi/180

  cairo_set_source_rgba (cr,rgba(color))
  cairo_arc_negative(cr, center_xpos, center_ypos, radius, start_angle, finish_angle)
end
function ram_arc_lines()
  top_sx = centerx - radius_in + offset_in + (math.sqrt(radius_in^2 - (height/2)^2))
  top_sy = centery - height/2
  top_fx   = centerx + offset_out
  top_fy   = top_sy
  bottom_sx = top_sx
  bottom_sy = centery - height/2 + ram_height
  bottom_fx = top_fx
  bottom_fy = bottom_sy
  draw_line(top_sx,top_sy,top_fx,top_fy)
  draw_line(bottom_sx, bottom_sy,bottom_fx,bottom_fy)
end
function ram_arc_pattern()
  sy = centery - height/2
  fy = centery + height/2
  pattern = cairo_pattern_create_linear (bottom_sx, sy, bottom_sx, fy)

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
function ram_indicator(x,y,spacing)
  font = "Inconsolata"
  font_size  = 15
  text1 = "ram"
  text2 = ram .. "%"
  color = color1
  displaytext(x,y,text1,font,font_size,color)
  y = y + spacing*font_size
  displaytext(x,y,text2,font,font_size,color)
end
