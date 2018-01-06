function network()
  down = downspeed
  up   = upspeed
  speedtest_interval = 600
  font_size = 15
  spacing = 10.5
  x = -50
  y = 340
  local color = color6

  speedtest_timer = (updates % speedtest_interval)
  if ic == 1 then
    if speedtest_timer == 0 or conky_start == 1 then
      os.execute("speedtest-cli --simple | sed 's/Ping/PNG/' | sed 's/Download/DWN/' | sed 's/Upload/UPL/' > "..curdir.."/.tmp/speeds &")
    end
    if speedtest_timer == 30 then -- xx seconds after launch, speedtest results start to show
      speedtest_t = {}
      result = io.open(curdir.."/.tmp/speeds")
      for line in result:lines() do
        table.insert(speedtest_t, line)
      end
      result:close()
    end

    if speedtest_t ~= nil then
      n = 1
      for i, line in ipairs (speedtest_t) do
        text = line
        x = x + font_size*spacing
        displaytext(x,y,text,font,font_size,color)
        n = n+1
      end
    end
    --download speed
    display_speed("DWN SPD",downspeed,600,135,1.5)
    display_speed("UPL SPD",upspeed  ,600,255,1.5)
  else
    font_size = 30
    local color = color5
    x = 220
    y = 250
    text = "INTERNET DISCONNECTED"
    displaytext(x,y,text,font,font_size,color)
  end
end

function display_speed(text1,speed,x,y,spacing)
  text2 = speed_convert_s(speed)
  font_size = 20
  local color = color1
  displaytext(x,y,text1,font,font_size,color)
  y = y + font_size*spacing
  displaytext(x,y,text2,font,font_size,color)
end

function speed_convert_s (speed)
  if tonumber(speed) < 100.0 then
    speed = round_float(speed,1)
    s = tostring(speed) .. " KiB"
    return s
  elseif tonumber(speed) < 100000.0 then
    speed = speed / 1000.0
    speed = round_float(speed,1)
    s = tostring(speed) .. " MiB"
    return s
  elseif tonumber(speed) < 100000000.0 then
    speed = speed / 1000000.0
    speed = round_float(speed,1)
    s = tostring(speed) .. " GiB"
    return s
  else
    speed = speed / 1000000.0
    speed = round_float(speed,1)
    s = tostring(speed) .. "GiB"
  end
end

function round_float(num, numDecimalPlaces) --string
  rounded = string.format("%." .. (numDecimalPlaces or 0) .. "f", num) -- string
  return rounded
end
