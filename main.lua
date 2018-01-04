package.path = os.getenv("HOME") ..  "/.config/conky/?.lua;" .. package.path

require 'cairo'

require 'clock'
require 'cpu'
require 'device_info'
require 'heading'
require 'information'
require 'network'
require 'process'
require 'ram'
require 'system_log'
require 'system_storage'
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
    -- OS detection
    osname = os_detection()

    cpu       = tonumber(conky_parse("${cpu}"))
    if cpu > 100 then
      cpu = 100
    elseif cpu < 0 then
      cpu = 0
    end
    memory    = tonumber(conky_parse("${memperc}"))

    internet_connected_wlp2s0 =
      tonumber(conky_parse("${if_existing /sys/class/net/wlp2s0/operstate up}1${else}0${endif}"))
    internet_connected_enp4s0 =
      tonumber(conky_parse("${if_existing /sys/class/net/enp4s0/operstate up}1${else}0${endif}"))
    internet_connected_wlp4s0 =
      tonumber(conky_parse("${if_existing /sys/class/net/wlp4s0/operstate up}1${else}0${endif}"))
    if     internet_connected_wlp2s0 == 1 then
      downspeed = conky_parse("${downspeedf wlp2s0}")
      upspeed   = conky_parse("${upspeedf wlp2s0}")
      internet_connected = 1
    elseif internet_connected_wlp4s0 == 1 then
      downspeed = conky_parse("${downspeedf wlp4s0}")
      upspeed   = conky_parse("${upspeedf wlp4s0}")
      internet_connected = 1
    elseif internet_connected_enp4s0 == 1 then
      downspeed = conky_parse("${downspeedf enp4s0}")
      upspeed   = conky_parse("${upspeedf enp4s0}")
      internet_connected = 1
    else
      downspeed = 0
      upspeed = 0
      internet_connected = 0
    end

    year    = os.date("%Y")
    month   = os.date("%m")
    monthn  = os.date("%B")
    day     = os.date("%d")
    weekdayn= os.date("%A")
    hours   = os.date("%H")
    hours12 = os.date("%I")
    hourapm = os.date("%p")
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

    heading1(100,770,"System Log")
    system_log(82,790)

    heading1(100,420,"Storage")
    system_storage(82,430)

    network()

    cpuarc()
    ramarc()

    heading3(795 ,835,"CPU")
    heading3(1100,835,"RAM")
    cpuprocess(700,850)
    cpu_info(700,982)
    ramprocess(1000,850)
    ram_info(1000,990)
    heading1(1290,770,"Info")
    information(1290,800)

    weather(1350,440)

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
  -- Usage
  -- x = extents.width  + extents.x_bearing
  -- y = extents.height + extents.y_bearing
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
function os_detection()
  if package.config:sub(1,1) == "\\" then
    osname = "Windows"
  else
    temp = assert(io.popen("cat /etc/issue"))
    for line in temp:lines() do
      for word in line:gmatch("%S+") do
        osname = word
        break
      end
      break
    end
    temp:close()
    return osname
  end
end
