function clock()
  draw_circle()
  datetime()
end
function draw_circle()
  center_x_c = 960
  center_y_c = 540
  radius_c = 220
  width_c = 4
  start_angle_c = 0
  end_angle_c = 2*math.pi
  bg_red_c = 1
  bg_green_c = 1
  bg_blue_c = 1
  bg_alpha_c = 0.7

  cairo_set_line_width (cr, width_c)
  cairo_set_source_rgba (cr, bg_red_c, bg_green_c, bg_blue_c, bg_alpha_c)
  cairo_arc (cr, center_x_c, center_y_c, radius_c, start_angle_c, end_angle_c)
  cairo_close_path (cr)
  cairo_stroke (cr)
end
function datetime()
  local extents=cairo_text_extents_t:create()
  tolua.takeownership(extents)

  dtcenter_font="Noto Sans"
  dtcenter_font_slant = CAIRO_FONT_SLANT_NORMAL
  dtcenter_font_face = CAIRO_FONT_WEIGHT_NORMAL
  dtcenter_font_size=96
  dtcenter_seconds=os.date("%S")
  dtcenter_minutes=os.date("%M")
  dtcenter_hours=os.date("%H")
  dtcenter_text = dtcenter_hours .. ":" .. dtcenter_minutes .. ":" .. dtcenter_seconds

  cairo_select_font_face (cr, dtcenter_font, dtcenter_font_slant, dtcenter_font_face)
  cairo_set_font_size (cr, dtcenter_font_size)
  cairo_set_source_rgba (cr,1,1,1,0.6)
  cairo_text_extents (cr, dtcenter_text, extents)
  dtcenter_xpos = screen_x/2 - (extents.width/2 + extents.x_bearing)
  dtcenter_ypos = screen_y/2 - (extents.height/2 + extents.y_bearing)
  cairo_move_to (cr, dtcenter_xpos, dtcenter_ypos)
  cairo_show_text (cr, dtcenter_text)
  cairo_stroke(cr)
end
