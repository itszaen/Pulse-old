require 'cairo'

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
    print ("conky is running!")

  -- Parsing --
    cpu     =tonumber(conky_parse("${cpu}"))
    memory  =tonumber(conky_parse("${memperc}"))
    internet_connected = tonumber(conky_parse("${if_up wlan0}1${else}0${endif}"))

  -- Object --
    --- Hello World ---
    ---- Property ----
    font_hw="Noto Sans"
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
    radius_c = 200
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
