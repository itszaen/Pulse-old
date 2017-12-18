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

  -- Info
  --[[
    --print ("conky is running!")
  ]]

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
    minutes = os.date("%M")
    seconds = os.date("%S")

    screen_x = 1920
    screen_y = 1080

    centerx = screen_x/2
    centery = screen_y/2

    -- Variable
    center = 440

    -- Objects
    dofile ("/home/zaen/.config/conky/heading.lua")

    dofile ("/home/zaen/.config/conky/clock.lua")
    clock()

    dofile ("/home/zaen/.config/conky/system_log.lua")
    heading("System Log",100,770)
    system_log(82,790)

    dofile ("/home/zaen/.config/conky/system_storage.lua")
    heading("Storage",100,450)
    system_storage(82,460)

    dofile ("/home/zaen/.config/conky/network.lua")
    network()

    dofile ("/home/zaen/.config/conky/cpu.lua")
    cpuarc()
    dofile ("/home/zaen/.config/conky/ram.lua")
    ramarc()

    dofile ("/home/zaen/.config/conky/process.lua")
    heading("CPU",795,860)
    heading("RAM",1100,860)
    cpuprocess(700,880)
    ramprocess(1000,880)

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
