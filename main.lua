require 'cairo'
dofile ("/home/zaen/.config/conky/ricing.lua")

conky_start = 1

function conky_main()
  if conky_window == nil then return end
  local cs = cairo_xlib_surface_create(
    conky_window.display,
    conky_window.drawable,
    conky_window.visual,
    conky_window.width,
    conky_window.height
  )
  cr = cairo_create(cs)


  updates = tonumber(conky_parse('${updates}'))
  if updates>1 then

  -- Info to terminal
  --- 'Conky is running' 1/s
    --print ("conky is running!")

  -- Parsing
    cpu       = tonumber(conky_parse("${cpu}"))
    memory    = tonumber(conky_parse("${memperc}"))
    internet_connected = tonumber(conky_parse("${if_up wlp2s0}1${else}0${endif}"))
    downspeed = conky_parse("${downspeedf}")
    upspeed   = conky_parse("${upspeedf}")

  -- Screen
    screen_x = 1920
    screen_y = 1080
  -- Object
    dofile ("/home/zaen/.config/conky/heading.lua")
    --- Circle
    dofile ("/home/zaen/.config/conky/circle.lua")
    draw_arc()
    radius_c = 220
    --- Date & Time
    dofile ("/home/zaen/.config/conky/datetime.lua")
    datetime()
    --- System Log
    heading("System Log",100,775)
    dofile ("/home/zaen/.config/conky/system_log.lua")
    system_log(82,790)
    --- System Storage Information
    heading("Storage",100,410)
    dofile ("/home/zaen/.config/conky/system_storage.lua")
    system_storage(82,420)
    --- Network Information
    dofile ("/home/zaen/.config/conky/network.lua")
    network()
    --- CPU Indicator Arc
    dofile ("/home/zaen/.config/conky/cpu.lua")
    ci_interval = 1
    ci_timer = (updates % ci_interval)
    ci_height = radius_c * 2 --500
    ci_cpu = cpu
    ci_cpu_height = ci_cpu * (ci_height/100.0)

    ---- Left
    ci_l_gap    = 300.0   -- between this and the r250 circle
    ci_l_radius = 300.0

    ci_l_range  =  2.0*((math.asin(ci_height / (ci_l_radius*2.0)))*180.0/math.pi) --91.1693 when radius is 350.0
    ci_l_bottom = 180.0 - ci_l_range/2.0 -- 134.4153 when radius is 350.0
    ci_l_degree = 90 + math.acos((radius_c-ci_cpu_height)/ci_l_radius)*180.0/math.pi

    ci_l_center_xpos = screen_x / 2 + ci_l_radius - ci_l_gap
    ci_l_center_ypos = screen_y / 2

    ci_l_start_angle = ci_l_bottom * math.pi/180.0
    ci_l_end_angle   = ci_l_degree * math.pi/180.0

    cairo_set_source_rgba (cr,1,1,1,1)
    cairo_arc (cr, ci_l_center_xpos, ci_l_center_ypos, ci_l_radius, ci_l_start_angle, ci_l_end_angle)

    ---- Right
    ci_r_gap = 295
    ci_r_radius = 290
    ci_r_range =  2*(math.asin(ci_height / (ci_r_radius*2)))*180/math.pi
    ci_r_bottom = 180.0 - ci_r_range/2.0
    ci_r_degree = 90 + math.acos((radius_c-ci_cpu_height)/ci_r_radius)*180.0/math.pi

    ci_r_center_xpos = screen_x / 2 + ci_r_radius - ci_r_gap
    ci_r_center_ypos = screen_y / 2

    ci_r_start_angle = ci_r_degree * math.pi/180
    ci_r_end_angle   = ci_r_bottom * math.pi/180
    -- the order here is important for filling to work properly

    cairo_set_source_rgba (cr,1,1,1,1)
    cairo_arc_negative(cr, ci_r_center_xpos, ci_r_center_ypos, ci_r_radius, ci_r_start_angle, ci_r_end_angle) --negative arc

    ---- Top & Bottom Line
    ci_top = 790.0 - ci_cpu_height

    ci_line_top_start_xpos = ci_l_center_xpos - ci_l_radius
    ci_line_top_start_ypos = ci_top
    ci_line_top_end_xpos = ci_r_center_xpos - (math.sqrt(ci_r_radius^2 - (ci_height/2)^2))
    ci_line_top_end_ypos = ci_top
    ci_line_bottom_start_xpos = ci_line_top_start_xpos
    ci_line_bottom_start_ypos = ci_r_center_ypos + ci_height/2
    ci_line_bottom_end_xpos = ci_line_top_end_xpos
    ci_line_bottom_end_ypos = ci_line_bottom_start_ypos
    cairo_move_to (cr, ci_line_top_start_xpos, ci_line_top_start_ypos)
    cairo_line_to (cr, ci_line_top_end_xpos, ci_line_top_end_ypos)
    cairo_move_to (cr, ci_line_bottom_start_xpos, ci_line_bottom_start_ypos)
    cairo_line_to (cr, ci_line_bottom_end_xpos,ci_line_bottom_end_ypos)

    ---- Drawing(filling)
    ci_pattern = cairo_pattern_create_linear (ci_line_top_start_xpos , 290.0, ci_line_top_start_xpos , 790.0)
    ci_pattern1_red, ci_pattern1_green, ci_pattern1_blue = 1,0,0 --red
    ci_pattern1_alpha = 1
    ci_pattern2_red, ci_pattern2_green, ci_pattern2_blue = 0,0,1 --blue
    ci_pattern2_alpha = 1
    ci_pattern3_red, ci_pattern3_green, ci_pattern3_blue = 0,1,0 --green
    ci_pattern3_alpha = 1
    ci_pattern4_red, ci_pattern4_green, ci_pattern4_blue = 1,1,0 --yellow
    ci_pattern4_alpha = 1

    cairo_pattern_add_color_stop_rgba (ci_pattern, 0,   ci_pattern1_red,ci_pattern1_green,ci_pattern1_blue,ci_pattern1_alpha)
    cairo_pattern_add_color_stop_rgba (ci_pattern, 0.5, ci_pattern4_red,ci_pattern4_green,ci_pattern4_blue,ci_pattern4_alpha)
    cairo_pattern_add_color_stop_rgba (ci_pattern, 0.8, ci_pattern3_red,ci_pattern3_green,ci_pattern3_blue,ci_pattern3_alpha)
    cairo_pattern_add_color_stop_rgba (ci_pattern, 1,   ci_pattern2_red,ci_pattern2_green,ci_pattern2_blue,ci_pattern2_alpha)
    cairo_set_source(cr, ci_pattern)
    cairo_fill(cr)

    --- RAM Indicator Arc
    -- Starts from the top --
    ri_interval = 1
    ri_timer    = (updates % ri_interval)
    ri_height   = radius_c * 2 --500
    ri_ram      = memory
    ri_ram_height = ri_ram * (ri_height/100.0)

    ---- Left
    ri_l_gap    = 295
    ri_l_radius = 290

    ri_l_range  =  (math.asin(ri_height / (ri_l_radius*2)))*180/math.pi
    ri_l_top    = 360.0 - ri_l_range
    ri_l_degree = 270.0 + math.acos((radius_c - ri_ram_height)/ri_l_radius)*180.0/math.pi

    ri_l_center_xpos = screen_x / 2 - ri_l_radius + ri_l_gap
    ri_l_center_ypos = screen_y / 2

    ri_l_start_angle = ri_l_top    *math.pi/180
    ri_l_end_angle   = ri_l_degree *math.pi/180

    cairo_set_source_rgba (cr,1,1,1,1)
    cairo_arc(cr, ri_l_center_xpos, ri_l_center_ypos, ri_l_radius, ri_l_start_angle, ri_l_end_angle)

    ---- Right
    ri_r_gap    = 300
    ri_r_radius = 300

    ri_r_range  =  (math.asin(ri_height / (ri_r_radius*2)))*180/math.pi
    ri_r_top    = 360.0 - ri_r_range
    ri_r_degree = 270.0 + math.acos((radius_c - ri_ram_height)/ri_r_radius)*180.0/math.pi

    ri_r_start_angle = ri_r_degree    *math.pi/180
    ri_r_end_angle   = ri_r_top *math.pi/180

    ri_r_center_xpos = screen_x / 2 - ri_r_radius + ri_r_gap
    ri_r_center_ypos = screen_y / 2

    cairo_set_source_rgba (cr,1,1,1,1)
    cairo_arc_negative(cr, ri_r_center_xpos, ri_r_center_ypos, ri_r_radius, ri_r_start_angle, ri_r_end_angle)

    ---- Top & Bottom Line
    ri_bottom = 290 + ri_ram_height
    ri_line_top_start_xpos = ri_l_center_xpos + (math.sqrt(ri_l_radius^2 - (ri_height/2)^2))
    ri_line_top_start_ypos = ri_l_center_ypos - ri_height/2
    ri_line_top_end_xpos =ri_r_center_xpos + ri_r_radius
    ri_line_top_end_ypos = ri_line_top_start_ypos
    ri_line_bottom_start_xpos = ri_line_top_start_xpos
    ri_line_bottom_start_ypos = ri_bottom
    ri_line_bottom_end_xpos = ri_line_top_end_xpos
    ri_line_bottom_end_ypos = ri_line_bottom_start_ypos
    cairo_move_to (cr, ri_line_top_start_xpos , ri_line_top_start_ypos)
    cairo_line_to (cr, ri_line_top_end_xpos   , ri_line_top_end_ypos)
    cairo_move_to (cr, ri_line_bottom_start_xpos , ri_line_bottom_start_ypos)
    cairo_line_to (cr, ri_line_bottom_end_xpos   , ri_line_bottom_end_ypos)

    ---- Drawing(filling)
    ri_pattern = cairo_pattern_create_linear (ri_line_bottom_start_xpos , 290.0, ri_line_bottom_start_xpos , 790.0)

    ri_pattern1_red, ri_pattern1_green, ri_pattern1_blue = 1,0,0 --red
    ri_pattern1_alpha = 1
    ri_pattern2_red, ri_pattern2_green, ri_pattern2_blue = 0,0,1 --blue
    ri_pattern2_alpha = 1
    ri_pattern3_red, ri_pattern3_green, ri_pattern3_blue = 0,1,0 --green
    ri_pattern3_alpha = 1
    ri_pattern4_red, ri_pattern4_green, ri_pattern4_blue = 1,1,0 --yellow
    ri_pattern4_alpha = 1

    cairo_pattern_add_color_stop_rgba (ri_pattern, 1,   ri_pattern1_red,ri_pattern1_green,ri_pattern1_blue,ri_pattern1_alpha)
    cairo_pattern_add_color_stop_rgba (ri_pattern, 0.8, ri_pattern4_red,ri_pattern4_green,ri_pattern4_blue,ri_pattern4_alpha)
    cairo_pattern_add_color_stop_rgba (ri_pattern, 0.5, ri_pattern3_red,ri_pattern3_green,ri_pattern3_blue,ri_pattern3_alpha)
    cairo_pattern_add_color_stop_rgba (ri_pattern, 0,   ri_pattern2_red,ri_pattern2_green,ri_pattern2_blue,ri_pattern2_alpha)

    cairo_set_source(cr, ri_pattern)
    cairo_fill(cr)

    ----
    conky_start = nil -- 1st time flag

  end -- if updates > 1
  --cairo_surface_destroy(ali_image)
  --cairo_pattern_destroy(cr)
  cairo_destroy(cr)
  cairo_surface_destroy(cs)
  cr = nil
end -- conky_main()

-- Functions
--- converts color in hexa to decimal
function rgb_to_r_g_b(colour, alpha)
  return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end
