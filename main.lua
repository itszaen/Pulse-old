package.path = os.getenv("HOME") ..  "/.config/conky/?.lua;" .. package.path

require 'cairo'

require 'clock'
require 'heading'
require 'system_log'
require 'system_storage'
require 'network'
require 'cpu'
require 'ram'
require 'process'
require 'information'
require 'weather'

conky_start = 1
home = os.getenv("HOME")
curdir = home .. "/.config/conky"

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

  -- Parsing
    cpu       = tonumber(conky_parse("${cpu}"))
    memory    = tonumber(conky_parse("${memperc}"))

    internet_connected_wlp2s0 =
    tonumber(conky_parse("${if_existing /sys/class/net/wlp2s0/operstate up}1${else}0${endif}"))
    internet_connected_enp4s0 =
    tonumber(conky_parse("${if_existing /sys/class/net/enp4s0/operstate up}1${else}0${endif}"))

    if     internet_connected_wlp2s0 == 1 then
      downspeed = conky_parse("${downspeedf wlp2s0}")
      upspeed   = conky_parse("${upspeedf wlp2s0}")
    elseif internet_connected_enp4s0 == 1 then
      downspeed = conky_parse("${downspeedf enp4s0}")
      upspeed   = conky_parse("${upspeedf enp4s0}")
    end

    year    = os.date("%Y")
    month   = os.date("%m")
    monthn  = os.date("%B")
    day     = os.date("%d")
    weekdayn= os.date("%A")
    hours   = os.date("%H")
    hours12 = os.date("%I")
    minutes = os.date("%M")
    seconds = os.date("%S")

    screen_x = 1920
    screen_y = 1080

    centerx = screen_x/2
    centery = screen_y/2

    -- Variable
    center = 440
    color1 = {0.68,0.68,1.00,0.8}
    color2 = {0.60,0.60,1.00,0.8}
    color3 = {0.68,0.68,1.00,1.0}
    color4 = {0.40,0.40,0.60,0.8}
    color5 = {0.60,0.60,1.00,0.6}
    color6 = {0.60,0.60,1.00,0.7}
    color7 = {0.68,0.68,1.00,0.6}
    -- Objects
    clock()

    heading("System Log",100,770)
    system_log(82,790)

    heading("Storage",100,450)
    system_storage(82,460)

    network()

    cpuarc()
    ramarc()

    heading("CPU",795,865,0)
    heading("RAM",1100,865,0)
    cpuprocess(700,880)
    ramprocess(1000,880)

    heading("Info",1300,770)
    information(1300,800)

    --weather()

    ----
    conky_start = nil -- 1st time flag

  end
  cairo_destroy(cr)
  cairo_surface_destroy(cs)
  cr = nil
end -- conky_main()

-- Functions
--- converts color in hexa to decimal
function rgb_to_r_g_b(colour, alpha)
  return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end
function displaytext(x,y,text,font,font_size,color)
  font_slant  = CAIRO_FONT_SLANT_NORMAL
  font_weight = CAIRO_FONT_WEIGHT_NORMAL
  cairo_select_font_face(cr,font,font_slant,font_face)
  cairo_set_font_size(cr,font_size)
  cairo_set_source_rgba (cr,rgba(color))
  cairo_move_to(cr,x,y)
  cairo_show_text(cr,text)
  cairo_stroke(cr)
end
function text_extents(text,font,font_size)
  font_slant  = CAIRO_FONT_SLANT_NORMAL
  font_weight = CAIRO_FONT_WEIGHT_NORMAL
  cairo_select_font_face(cr,font,font_slant,font_face)
  cairo_set_font_size(cr,font_size)
  extents = cairo_text_extents_t:create()
  tolua.takeownership(extents)
  cairo_text_extents(cr,text,extents)
end
function rgba(color)
  r = color[1]
  g = color[2]
  b = color[3]
  a = color[4]
  return r,g,b,a
end
function draw_line(startx,starty,finishx,finishy)
  cairo_move_to (cr, startx , starty)
  cairo_line_to (cr, finishx, finishy)
  cairo_close_path(cr)
end
