function draw_arc()
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
