package.path = os.getenv("HOME") ..  "/.config/conky/?.lua;" .. package.path
require 'cairo'
require 'lfs'

conky_start = 1

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

home = os.getenv("HOME")
curdir = home .. "/.config/conky"
tmpdir = curdir.."/.tmp"

dofile(curdir.."/src/common.lua")

SCREENX,SCREENY = 1920,1080 -- the resolution this program is written for

screen_x = 1920
screen_y = 1080

scalex = screen_x/SCREENX
scaley = screen_y/SCREENY

if not is_directory(tmpdir) then
  lfs.mkdir(tmpdir)
end
osname = os_detection()

function conky_main()
  dofile(curdir.."/config.lua")
  dofile(curdir.."/src/common.lua")
  dofile(curdir.."/src/calendar.lua")
  dofile(curdir.."/src/clock.lua")
  dofile(curdir.."/src/cpu.lua")
  dofile(curdir.."/src/device_info.lua")
  dofile(curdir.."/src/dictionary.lua")
  dofile(curdir.."/src/heading.lua")
  dofile(curdir.."/src/information.lua")
  dofile(curdir.."/src/network.lua")
  dofile(curdir.."/src/process.lua")
  dofile(curdir.."/src/ram.lua")
  dofile(curdir.."/src/system_log.lua")
  dofile(curdir.."/src/system_storage.lua")
  dofile(curdir.."/src/weather.lua")
  print(config.gmail.address)

  if conky_window == nil then return end
  local cs = cairo_xlib_surface_create(
    conky_window.display,
    conky_window.drawable,
    conky_window.visual,
    screen_x,
    screen_y
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
    calendar(1320,80)
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
