require 'cairo'

function conky_main()
  if conky_window == nil then
    return
  end
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
    print ("conky is running!")

    --Parsing--
    cpu     =tonumber(conky_parse("${cpu}"))
    memory  =tonumber(conky_parse("${memperc}"))
    internet_connected = tonumber(conky_parse("${if_up wlan0}1${else}0${endif}"))

    -- Values --
    font="Noto Sans"
    font_size=64
    text="hello world"
    xpos,ypos=100,100
    red,green,blue,alpha=1,1,1,1
    font_slant=CAIRO_FONT_SLANT_NORMAL
    font_face=CAIRO_FONT_WEIGHT_NORMAL

    line_width=3
    line_cap=CAIRO_LINE_CAP_BUTT
    red,green,blue,alpha=1,1,1,1
    startx=200
    starty=200
    endx=startx+(cpu*20)
    endy=starty
    -- Drawing --
    cairo_select_font_face (cr, font, font_slant, font_face);
    cairo_set_font_size (cr, font_size)
    cairo_set_source_rgba (cr,red,green,blue,alpha)
    cairo_move_to (cr,xpos,ypos)
    cairo_show_text (cr,text)

    cairo_set_line_width (cr,line_width)
    cairo_set_line_cap  (cr, line_cap)
    cairo_set_source_rgba (cr,red,green,blue,alpha)
    cairo_move_to (cr,startx,starty)
    cairo_line_to (cr,endx,endy)

    cairo_stroke (cr)
    ----------------------------
   end


  cairo_destroy(cr)
  cairo_surface_destroy(cs)
  cr = nil
end

-- converts color in hexa to decimal
function rgb_to_r_g_b(colour, alpha)
  return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end
