package.path = os.getenv("HOME") ..  "/.config/conky/?.lua;" .. package.path
require 'cairo'
require 'lfs'

conky_start = 1
curdir = lfs.currentdir() --home .. "/.config/conky"
tmpdir = curdir.."/.tmp"

-- require 'calendar'
-- require 'clock'
-- require 'cpu'
-- require 'device_info'
-- require 'heading'
-- require 'information'
-- require 'network'
-- require 'process'
-- require 'ram'
-- require 'system_log'
-- require 'system_storage'
-- require 'weather'
dofile(curdir.."/common.lua")
dofile(curdir.."/calendar.lua")
dofile(curdir.."/clock.lua")
dofile(curdir.."/cpu.lua")
dofile(curdir.."/device_info.lua")
dofile(curdir.."/dictionary.lua")
dofile(curdir.."/heading.lua")
dofile(curdir.."/information.lua")
dofile(curdir.."/network.lua")
dofile(curdir.."/process.lua")
dofile(curdir.."/ram.lua")
dofile(curdir.."/system_log.lua")
dofile(curdir.."/system_storage.lua")
dofile(curdir.."/weather.lua")

if not is_directory(tmpdir) then
  lfs.mkdir(tmpdir)
end
osname = os_detection()

function conky_main()
  if conky_window == nil then return end
  local cs = cairo_xlib_surface_create(
    conky_window.display,
    conky_window.drawable,
    conky_window.visual,
    1920,1080
    --conky_window.width,
    --conky_window.height
  )
  cr = cairo_create(cs)

  updates = tonumber(conky_parse('${updates}'))
  if updates>1 then

  -- Parsing
    cpu    = tonumber(conky_parse("${cpu}"))
    memory = tonumber(conky_parse("${memperc}"))
    wlp2s0 = tonumber(conky_parse("${if_existing /sys/class/net/wlp2s0/operstate up}1${else}0${endif}"))
    enp4s0 = tonumber(conky_parse("${if_existing /sys/class/net/enp4s0/operstate up}1${else}0${endif}"))
    wlp4s0 = tonumber(conky_parse("${if_existing /sys/class/net/wlp4s0/operstate up}1${else}0${endif}"))
    if wlp2s0 == 1 then
      downspeed = conky_parse("${downspeedf wlp2s0}")
      upspeed   = conky_parse("${upspeedf wlp2s0}")
      ic = 1
    elseif wlp4s0 == 1 then
      downspeed = conky_parse("${downspeedf wlp4s0}")
      upspeed   = conky_parse("${upspeedf wlp4s0}")
      ic = 1
    elseif enp4s0 == 1 then
      downspeed = conky_parse("${downspeedf enp4s0}")
      upspeed   = conky_parse("${upspeedf enp4s0}")
      ic = 1
    else
      downspeed = 0
      upspeed = 0
      ic = 0
    end

    year    = os.date("%Y")
    month   = os.date("%m")
    month_name  = os.date("%B")
    month_name_ab = os.date("%b")
    day     = os.date("%d")
    weekdayn= os.date("%A")
    weekday_name_ab = os.date("%a")
    weekday_number = tonumber(os.date("%w"))
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
    color8 = {0.40,0.40,0.60,0.6}
    purple_dark = {0.17,0.18,0.26,0.4}
    font = "Inconsolata"
    -- Objects
    calendar(1270,80)
    clock(centerx,centery)
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
    heading1(1600,770,"Word of the Day")
    word_of_the_day(1600,800)

    ----
    conky_start = nil -- 1st time flag

  end
  cairo_destroy(cr)
  cairo_surface_destroy(cs)
  cr = nil
end -- conky_main()
