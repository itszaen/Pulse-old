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

  -- Info to terminal --
  --- 'Conky is running' 1/s ---
    --print ("conky is running!")

  -- Parsing --
    cpu     =tonumber(conky_parse("${cpu}"))
    memory  =tonumber(conky_parse("${memperc}"))
    internet_connected = tonumber(conky_parse("${if_up wlan0}1${else}0${endif}"))

  -- Screen --
    screen_x = 1920
    screen_y = 1080
  -- Object --
   --- Hello World ---
    ---- Property ----
    --[[font_hw="Noto Sans"
    font_size_hw=64
    text1_hw="hello world"
    xpos_hw,ypos_hw=100,100
    red_hw,green_hw,blue_hw,alpha_hw=1,1,1,1
    font_slant_hw=CAIRO_FONT_SLANT_NORMAL
    font_face_hw=CAIRO_FONT_WEIGHT_NORMAL
    ---- Drawing ----
    cairo_select_font_face (cr, font_hw, font_slant_hw, font_face_hw)
    cairo_set_font_size (cr, font_size_hw)
    cairo_set_source_rgba (cr,red_hw,green_hw,blue_hw,alpha_hw)
    cairo_move_to (cr,xpos_hw,ypos_hw)
    cairo_show_text (cr,text1_hw)
    cairo_stroke(cr)
    ]]

    --- CPU Usage Bar ---
    ---- Property ----
    line_width=3
    line_cap=CAIRO_LINE_CAP_BUTT
    red,green,blue,alpha=1,1,1,1
    startx=200
    starty=200
    endx=startx+(cpu*20)
    endy=starty
    ---- Drawing ----
    cairo_set_line_width (cr,line_width)
    cairo_set_line_cap  (cr, line_cap)
    cairo_set_source_rgba (cr,red,green,blue,alpha)
    cairo_move_to (cr,startx,starty)
    cairo_line_to (cr,endx,endy)
    cairo_stroke (cr)

    --- Circle ---
    ---- Property ----
    center_x_c = 960
    center_y_c = 540
    radius_c = 250
    width_c = 5
    start_angle_c = 0
    end_angle_c = 2*math.pi
    bg_red_c = 1
    bg_green_c = 1
    bg_blue_c = 1
    bg_alpha_c = 1
    ---- Draw ----
    cairo_set_line_width (cr, width_c)
    cairo_set_source_rgba (cr, bg_red_c, bg_green_c, bg_blue_c, bg_alpha_c)
    cairo_arc (cr, center_x_c, center_y_c, radius_c, start_angle_c, end_angle_c)
    cairo_close_path (cr)
    cairo_stroke (cr)

    --- Date & Time ---
    local extents=cairo_text_extents_t:create()
    tolua.takeownership(extents)
    ---- Property ----
    dtcenter_font="Noto Sans"
    dtcenter_font_slant = CAIRO_FONT_SLANT_NORMAL
    dtcenter_font_face = CAIRO_FONT_WEIGHT_NORMAL
    dtcenter_font_size=96
    dtcenter_seconds=os.date("%S")
    dtcenter_minutes=os.date("%M")
    dtcenter_hours=os.date("%H")
    dtcenter_text = dtcenter_hours .. ":" .. dtcenter_minutes .. ":" .. dtcenter_seconds
    --dtcenter_time = tonumber(os.date("%X"))
    --dtcenter_text = dtcenter_time .. ":"
    ---- Drawing ----
    cairo_select_font_face (cr, dtcenter_font, dtcenter_font_slant, dtcenter_font_face)
    cairo_set_font_size (cr, dtcenter_font_size)
    cairo_set_source_rgba (cr,1,1,1,1)
    cairo_text_extents (cr, dtcenter_text, extents)
    dtcenter_xpos = screen_x/2 - (extents.width/2 + extents.x_bearing)
    dtcenter_ypos = screen_y/2 - (extents.height/2 + extents.y_bearing)
    cairo_move_to (cr, dtcenter_xpos, dtcenter_ypos)
    cairo_show_text (cr, dtcenter_text)
    cairo_stroke(cr)
    --- System Log ---
    ---- Property ----
    --local file = io.open()
    ---- Drawing ----

    --- System Storage Information ---
    cairo_select_font_face (cr, info_ss_font, info_ss_font_slant, info_ss_font_face)
    cairo_set_font_size (cr, info_ss_font_size)
    cairo_set_source_rgba(cr,1,1,1,1)
    info_ss_interval = 10
    info_ss_timer = (updates % info_ss_interval)
    ---- Property ----
    info_ss_font="Inconsolata"
    info_ss_font_slant = CAIRO_FONT_SLANT_NORMAL
    info_ss_font_face = CAIRO_FONT_WEIGHT_NORMAL
    info_ss_font_size = 20
    info_ss_xpos = 20
    info_ss_ypos = 400


    if info_ss_timer == 0 or conky_start == 1 then
    v_content = {}
      ss_file = io.popen("df -h")
      for line in ss_file:lines() do
        df_output = line
        table.insert(v_content, df_output)
      end
      ss_file:close()
    end
    n = 1
    for i, line in ipairs(v_content) do
      df_output = line
      info_ss_ypos = info_ss_ypos + info_ss_font_size*2.4
      cairo_move_to (cr,info_ss_xpos ,info_ss_ypos)
      cairo_show_text (cr, df_output)
      n = n + 1
    end
    conky_start = nil
    cairo_stroke (cr)

  end

  cairo_destroy(cr)
  cairo_surface_destroy(cs)
  cr = nil
end

-- Functions --
--- converts color in hexa to decimal ---
function rgb_to_r_g_b(colour, alpha)
  return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end
function magiclines(str)
  local s = tostring(str)
  a = type(s)
  print (a)
  if s:sub(-1)~="\n" then s=s.."\n" end
  return s:gmatch("(.-)\n")
end
