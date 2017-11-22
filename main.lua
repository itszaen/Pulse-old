require 'cairo'

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


  local updates = tonumber(conky_parse('${updates}'))
  if updates>1 then

  -- Info to terminal
  --- 'Conky is running' 1/s
    --print ("conky is running!")

  -- Parsing
    cpu     =tonumber(conky_parse("${cpu}"))
    memory  =tonumber(conky_parse("${memperc}"))
    internet_connected = tonumber(conky_parse("${if_up wlan0}1${else}0${endif}"))

  -- Screen
    screen_x = 1920
    screen_y = 1080
  -- Object
    --- Arch Linux Image
--[[
    ali_surface = cairo_image_surface_create_from_png ("~/.config/conky/image/ArchLinux.png")
    ali_width = cairo_image_surface_get_width(ali_image)
    ali_height = cairo_image_surface_get_height(ali_image)

    cairo_scale (cr, 1, 1)
    cairo_set_source_surface (ali_surface, ali_image, 0, 0)
  cairo_paint (cr) ]]
    --- Circle
    ---- Property
    center_x_c = 960
    center_y_c = 540
    radius_c = 250
    width_c = 4
    start_angle_c = 0
    end_angle_c = 2*math.pi
    bg_red_c = 1
    bg_green_c = 1
    bg_blue_c = 1
    bg_alpha_c = 0.7
    ---- Draw
    cairo_set_line_width (cr, width_c)
    cairo_set_source_rgba (cr, bg_red_c, bg_green_c, bg_blue_c, bg_alpha_c)
    cairo_arc (cr, center_x_c, center_y_c, radius_c, start_angle_c, end_angle_c)
    cairo_close_path (cr)
    cairo_stroke (cr)

    --- Date & Time
    local extents=cairo_text_extents_t:create()
    tolua.takeownership(extents)
    ---- Property
    dtcenter_font="Noto Sans"
    dtcenter_font_slant = CAIRO_FONT_SLANT_NORMAL
    dtcenter_font_face = CAIRO_FONT_WEIGHT_NORMAL
    dtcenter_font_size=96
    dtcenter_seconds=os.date("%S")
    dtcenter_minutes=os.date("%M")
    dtcenter_hours=os.date("%H")
    dtcenter_text = dtcenter_hours .. ":" .. dtcenter_minutes .. ":" .. dtcenter_seconds
    ---- Drawing
    cairo_select_font_face (cr, dtcenter_font, dtcenter_font_slant, dtcenter_font_face)
    cairo_set_font_size (cr, dtcenter_font_size)
    cairo_set_source_rgba (cr,1,1,1,0.6)
    cairo_text_extents (cr, dtcenter_text, extents)
    dtcenter_xpos = screen_x/2 - (extents.width/2 + extents.x_bearing)
    dtcenter_ypos = screen_y/2 - (extents.height/2 + extents.y_bearing)
    cairo_move_to (cr, dtcenter_xpos, dtcenter_ypos)
    cairo_show_text (cr, dtcenter_text)
    cairo_stroke(cr)

    --- System Log
    cairo_select_font_face (cr, sl_font, sl_font_slant, sl_font_face)
    cairo_set_font_size (cr, sl_font_size)
    cairo_set_source_rgba(cr,1,1,1,0.7)
    sl_interval = 1
    sl_timer = (updates % sl_interval)
    ---- Property
    sl_font="Inconsolata"
    sl_font_slant = CAIRO_FONT_SLANT_NORMAL
    sl_font_face = CAIRO_FONT_WEIGHT_NORMAL
    sl_font_size = 13
    sl_xpos = 40
    sl_ypos = 650


    if sl_timer == 0 or conky_start == 1 then
      sl_content_table = {}
      os.execute("~/.config/conky/journal_dump.sh")
      sl_file = io.open("/home/zaen/.journal.txt", "r")
      for line in sl_file:lines() do
        sl_content = line
        table.insert(sl_content_table, sl_content)
      end
      sl_file:close()
    end
    n = 1
    for i, line in ipairs (sl_content_table) do
      sl_content = line
      sl_ypos = sl_ypos + sl_font_size*1.3
      cairo_move_to (cr,sl_xpos , sl_ypos)
      cairo_show_text (cr, sl_content)
      n = n+1
    end

    --- System Storage Information
    cairo_select_font_face (cr, ss_font, ss_font_slant, ss_font_face)
    cairo_set_font_size (cr, ss_font_size)
    cairo_set_source_rgba(cr,1,1,1,0.7)
    ss_interval = 10
    ss_timer = (updates % ss_interval)
    ---- Property
    ss_font="Inconsolata"
    ss_font_slant = CAIRO_FONT_SLANT_NORMAL
    ss_font_face = CAIRO_FONT_WEIGHT_NORMAL
    ss_font_size = 18
    ss_xpos = 40
    ss_ypos = 400
    ---- Function
    if ss_timer == 0 or conky_start == 1 then
    ss_content_table = {}
      ss_file = io.popen("df -h")
      for line in ss_file:lines() do
        ss_content = line
        table.insert(ss_content_table, ss_content)
      end
      ss_file:close()
    end
    n = 1
    for i, line in ipairs(ss_content_table) do
      ss_content = line
      ss_ypos = ss_ypos + ss_font_size*1.4
      cairo_move_to (cr,ss_xpos ,ss_ypos)
      cairo_show_text (cr, ss_content)
      n = n + 1
    end
    cairo_stroke (cr)

    --- CPU Indicator Arc
    ci_interval = 10
    ci_timer = (updates % ci_interval)
    ci_width = 1
    ci_height = radius_c * 2
--[[rb = right bottom
    rt = right top
    lb = left bottom
    lt = left top
    ra = right arc
    la = left arc
]]
    ci_cpu = cpu
print(ci_cpu)
ci_rt_ypos = 790 - ci_cpu * (290/100)
    ci_rt_xpos = 865

    ci_lt_ypos = 790 - ci_cpu*290/100
    ci_lt_xpos = ci_rt_xpos - 45

    ci_ra_ypos = 540
    ci_ra_xpos = 720
    ci_la_xpos, ci_la_ypos = ci_ra_xpos - 20, 540

    ci_rb_xpos, ci_rb_ypos = 865,790
    ci_lb_xpos, ci_lb_ypos = 820,790

    cairo_move_to (cr,ci_rb_xpos, ci_rb_ypos)
    cairo_curve_to (cr,ci_ra_xpos, ci_ra_ypos, ci_ra_xpos, ci_ra_ypos, ci_rt_xpos,ci_rt_ypos)
    --cairo_move_to (cr,ci_rt_xpos, ci_rt_ypos)
    cairo_line_to (cr,ci_lt_xpos, ci_lt_ypos)
    --cairo_move_to (cr,ci_lt_xpos, ci_lt_ypos)
    cairo_curve_to (cr, ci_la_xpos, ci_la_ypos, ci_la_xpos, ci_la_ypos,ci_lb_xpos, ci_lb_ypos)
    --cairo_move_to (cr,ci_lb_xpos, ci_lb_ypos)
    cairo_line_to (cr,ci_rb_xpos, ci_rb_ypos)
    cairo_set_line_join (cr,CAIRO_LINE_JOIN_MITER)
    cairo_set_line_width(cr, 1)
    cairo_set_source_rgba(cr, 1,1,1,1)
    cairo_fill_preserve(cr)
    cairo_set_source_rgba(cr, 1,1,1,1)
    cairo_stroke (cr)

----------

-----------
      ---- Left x Left
    ci_ll_gap    = 280   -- between this and the r250 circle
    ci_ll_radius = 350
    ci_ll_range  =  (math.asin(ci_height / (ci_ll_radius*2)))*180/math.pi   -- perfect range to cover from bottom to top of the adjacent ring
    ci_ll_start_angle = (180 - ci_ll_range)*math.pi/180
    ci_ll_end_angle   = (180 + ci_ll_range)*math.pi/180
    ci_ll_center_xpos = screen_x / 2 + ci_ll_radius - ci_ll_gap
    ci_ll_center_ypos = screen_y / 2
    cairo_set_line_width (cr,ci_width)
    cairo_set_source_rgba (cr,1,1,1,1)
    cairo_arc (cr, ci_ll_center_xpos, ci_ll_center_ypos, ci_ll_radius, ci_ll_start_angle, ci_ll_end_angle)
    cairo_stroke (cr)
    ---- Left x Right
    ci_lr_gap = 250
    ci_lr_radius = 280
    ci_lr_range =  (math.asin(ci_height / (ci_lr_radius*2)))*180/math.pi
    ci_lr_start_angle = (180 - ci_lr_range)*math.pi/180
    ci_lr_end_angle   = (180 + ci_lr_range)*math.pi/180
    ci_lr_center_xpos = screen_x / 2 + ci_lr_radius - ci_lr_gap
    ci_lr_center_ypos = screen_y / 2
    cairo_set_line_width (cr, ci_width)
    cairo_set_source_rgba (cr,1,1,1,1)
    cairo_arc(cr, ci_lr_center_xpos, ci_lr_center_ypos, ci_lr_radius, ci_lr_start_angle, ci_lr_end_angle)
    cairo_stroke (cr)
    ---- Right x Left
    ci_rl_gap = 250
    ci_rl_radius = 280
    ci_rl_range =  (math.asin(ci_height / (ci_rl_radius*2)))*180/math.pi
    ci_rl_start_angle = (0 - ci_rl_range)*math.pi/180
    ci_rl_end_angle   = (0 + ci_rl_range)*math.pi/180
    ci_rl_center_xpos = screen_x / 2 - ci_rl_radius + ci_rl_gap
    ci_rl_center_ypos = screen_y / 2
    cairo_set_line_width (cr, ci_width)
    cairo_set_source_rgba (cr,1,1,1,1)
    cairo_arc(cr, ci_rl_center_xpos, ci_rl_center_ypos, ci_rl_radius, ci_rl_start_angle, ci_rl_end_angle)
    cairo_stroke (cr)
    ---- Right x Right
    ci_rr_gap = 280
    ci_rr_radius = 350
    ci_rr_range =  (math.asin(ci_height / (ci_rr_radius*2)))*180/math.pi
    ci_rr_start_angle = (0 - ci_rr_range)*math.pi/180
    ci_rr_end_angle   = (0 + ci_rr_range)*math.pi/180
    ci_rr_center_xpos = screen_x / 2 - ci_rr_radius + ci_rr_gap
    ci_rr_center_ypos = screen_y / 2
    cairo_set_line_width (cr, ci_width)
    cairo_set_source_rgba (cr,1,1,1,1)
    cairo_arc(cr, ci_rr_center_xpos, ci_rr_center_ypos, ci_rr_radius, ci_rr_start_angle, ci_rr_end_angle)
    cairo_stroke (cr)
    ----
    cairo_move_to (cr, 500, ci_rt_ypos)
    cairo_line_to (cr, 1000, ci_rt_ypos)
    cairo_move_to (cr, 500, 790)
    cairo_line_to (cr, 1000,790)
    cairo_set_line_width (cr, 1)
    cairo_set_source_rgba(cr, 1,1,1,1)
    cairo_fill_preserve(cr)
    cairo_stroke(cr)
    ----

    conky_start = nil -- 1st time flag

  end -- if updates > 1
  -- cairo_surface_destroy(ali_image)
  cairo_destroy(cr)
  cairo_surface_destroy(cs)
  cr = nil
end -- conky_main()

-- Functions
--- converts color in hexa to decimal
function rgb_to_r_g_b(colour, alpha)
  return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end
