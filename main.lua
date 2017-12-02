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

    internet_connected_wlp2s0 =
    tonumber(conky_parse("${if_up wlp2s0}1${else}0${endif}"))
    internet_connected_enp4s0 =
    tonumber(conky_parse("${if_up enp4s0}1${else}0${endif}"))

    if     internet_connected_wlp2s0 == 1 then
      downspeed = conky_parse("${downspeedf wlp2s0}")
      upspeed   = conky_parse("${upspeedf wlp2s0}")
    elseif internet_connected_enp4s0 == 1 then
      downspeed = conky_parse("${downspeedf enp4s0}")
      upspeed   = conky_parse("${upspeedf enp4s0}")
    end
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
    heading("System Log",100,770)
    dofile ("/home/zaen/.config/conky/system_log.lua")
    system_log(82,790)
    --- System Storage Information
    heading("Storage",100,450)
    dofile ("/home/zaen/.config/conky/system_storage.lua")
    system_storage(82,460)
    --- Network Information
    dofile ("/home/zaen/.config/conky/network.lua")
    network()
    --- CPU Indicator Arc
    dofile ("/home/zaen/.config/conky/cpu.lua")
    cpuarc()
    --- Process
    heading("CPU",805,860)
    heading("RAM",1095,860)
    dofile ("/home/zaen/.config/conky/process.lua")
    cpuprocess(725,880)
    ramprocess(1015,880)

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
