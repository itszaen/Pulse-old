require 'drawimage'

function weather(x,y)
  interval = 300
  timer = (updates % interval)
  area = "Tokyo" -- available currently: Tokyo

  if timer == 0 or conky_start == 1 then
    file = io.open(curdir .. "/.tmp/weather_" .. area)
    weather_t = {}
    for line in file:lines() do
      file_content = line
      table.insert(weather_t,file_content)
    end
    file:close()
  end

  if timer == 0 or conky_start == 1 then
    file = io.open(curdir .. "/.tmp/weather_forecasts_" .. area)
    forecast_t = {}
    for line in file:lines() do
      file_content = line
      table.insert(forecast_t,file_content)
    end
    file:close()
  end

  location_t = {
    ['Tokyo'] = "Tokyo,Japan",
    ['California'] = "California,United States"
  }

  weather_icon_day_t = {
    ['Fair'] = "day-sunny",
    ['Clear'] = "day-sunny",
    ['Fair / Windy'] = "day-windy"
  }

  weather_icon_night_t = {
    ['Fair'] = "night-clear",
    ['Clear'] = "night-clear",
    ['Fair / Windy'] = 'windy'
  }

  location = location_t[area]

  temperature      = weather_t[1]
  temperature_high = weather_t[2]
  temperature_low  = weather_t[3]
  summary          = weather_t[4]
  wind_speed       = weather_t[5]
  wind_gust        = weather_t[6]
  wind_direction   = weather_t[7]
  visibility       = weather_t[8]
  precip_chance    = weather_t[9]
  dew_point        = weather_t[10]
  humidity         = weather_t[11]
  air_pressure     = weather_t[12]
  uv_index         = weather_t[13]
  uv_text          = weather_t[14]
  sunrise          = weather_t[15]
  sunset           = weather_t[16]
  moon_phase       = weather_t[17]
  last_update      = weather_t[18]
  observation      = weather_t[19]
  moon_phase_text  = weather_t[20]

  second_date = forecast_t[1]
  second_day_of_week = forecast_t[2]
  second_temp_high = forecast_t[3]
  second_temp_low = forecast_t[4]
  second_humidity = forecast_t[5]
  second_precip_chance = forecast_t[6]
  second_text = forecast_t[7]
  third_date = forecast_t[8]
  third_day_of_week = forecast_t[9]
  third_temp_high = forecast_t[10]
  third_temp_low = forecast_t[11]
  third_humidity = forecast_t[12]
  third_precip_chance = forecast_t[13]
  third_text = forecast_t[14]
  fourth_date = forecast_t[15]
  fourth_day_of_week = forecast_t[16]
  fourth_temp_high = forecast_t[17]
  fourth_temp_low = forecast_t[18]
  fourth_humidity = forecast_t[19]
  fourth_precip_chance = forecast_t[20]
  fourth_text = forecast_t[21]


  color = color6
  weather_icon_size = 50
  text_indent = iconsize + 15
  start1y = 35
  indent1 = 150
  spacing2 = 42
  start2x = x
  start2y = y + 82
  spacing3 = spacing2
  start3x = 150
  start3y = 82
  start4x = 250
  start4y = -35
  spacing4 = 30

  -- temperature
  font = "Roboto"
  font_size = 80
  text = temperature
  text_extents(text,font,font_size)
  x1 = x + 40 - (extents.width + extents.x_bearing)*1/2
  y1 = y
  displaytext(x1,y1,text,font,font_size,color)
  iconx = x + 45
  icony = y - 100
  iconpath = curdir .. "/image/weather_icons/celsius.svg"
  iconname = "celsius"
  iconsize = 165
  iconorig = 30
  draw_image(iconx,icony,iconpath,iconname,iconsize,iconorig,color6)

  -- element 1
  font_size = 17
  iconsize = 25
  iconorig = 30
  iconx = x + indent1
  icony = y + start1y - 18
  iconpath = curdir .. "/image/weather_icons/thermometer.svg"
  iconname = "thermometer"
  draw_image(iconx,icony,iconpath,iconname,iconsize,iconorig,color6)
  text = temperature_high .. "/" .. temperature_low
  x2 = x + indent1 + text_indent - 15
  y2 = y + start1y
  displaytext(x2,y2,text,font,font_size,color)

  --font = "Inconsolata"
  font_size = 18
  text = summary
  x3 = x + 10
  y3 = y2
  displaytext(x3,y3,text,font,font_size,color)

  -- element 2
  font_size = 14

  iconx = start2x
  icony = start2y - 25
  iconpath = curdir .. "/image/weather_icons/humidity.svg"
  iconname = "humidity"
  draw_image(iconx,icony,iconpath,iconname,40,30,color6)
  text = humidity
  x4 = iconx + text_indent
  y4 = start2y
  displaytext(x4,y4,text,font,font_size,color)

  iconx = iconx
  icony = icony + spacing2
  iconpath = curdir .. "/image/weather_icons/umbrella.svg"
  iconname = "umbrella"
  draw_image(iconx,icony,iconpath,iconname,40,30,color6)
  text = precip_chance
  x5 = x4
  y5 = y4 + spacing2
  displaytext(x5,y5,text,font,font_size,color)

  iconx = iconx
  icony = icony + spacing2
  iconpath = curdir .. "/image/weather_icons/windy.svg"
  iconname = "wind"
  draw_image(iconx,icony,iconpath,iconname,40,30,color6)
  text = wind_speed
  x6 = x5
  y6 = y5 + spacing2
  displaytext(x6,y6,text,font,font_size,color)

  iconx = iconx
  icony = icony + spacing2
  iconpath = curdir .. "/image/weather_icons/barometer.svg"
  iconname = "barometer"
  draw_image(iconx,icony,iconpath,iconname,40,30,color6)
  text = air_pressure
  x7 = x6
  y7 = y6 + spacing2
  displaytext(x7,y7,text,font,font_size,color)

  iconx = iconx
  icony = icony + spacing2
  iconpath = curdir .. "/image/weather_icons/uv.svg"
  iconname = "uv"
  draw_image(iconx,icony,iconpath,iconname,35,512,color6)
  text = uv_text
  x8 = x7
  y8 = y7 + spacing2
  displaytext(x8,y8,text,font,font_size,color)

  -- element 3
  iconx = iconx + start3x
  icony = start2y - 25
  iconpath = curdir .. "/image/weather_icons/smog.svg"
  iconname = "visibility"
  draw_image(iconx,icony,iconpath,iconname,40,30,color6)
  text = visibility
  x9 = x + start3x + text_indent
  y9 = y + start3y
  displaytext(x9,y9,text,font,font_size,color)

  iconx = iconx
  icony = icony + spacing2
  iconpath = curdir .. "/image/weather_icons/raindrops.svg"
  iconname = "dewpoint"
  draw_image(iconx,icony,iconpath,iconname,40,30,color6)
  text = dew_point
  x10 = x9
  y10 = y9 + spacing3
  displaytext(x10,y10,text,font,font_size,color)

  iconx = iconx
  icony = icony + spacing2
  iconpath = curdir .. "/image/weather_icons/sunrise.svg"
  iconname = "sunrise"
  draw_image(iconx,icony,iconpath,iconname,40,30,color6)
  text = sunrise
  x11 = x10
  y11 = y10 + spacing3
  displaytext(x11,y11,text,font,font_size,color)

  iconx = iconx
  icony = icony + spacing2
  iconpath = curdir .. "/image/weather_icons/sunset.svg"
  iconname = "sunset"
  draw_image(iconx,icony,iconpath,iconname,40,30,color6)
  text = sunset
  x12 = x11
  y12 = y11 + spacing3
  displaytext(x12,y12,text,font,font_size,color)

  iconx = iconx
  icony = icony + spacing2
  iconpath = curdir .. "/image/weather_icons/moon-"..moon_phase..".svg"
  iconname = "moonphase"
  draw_image(iconx,icony,iconpath,iconname,40,30,color6)

  n = 0

  text = {}
  for i in string.gmatch(moon_phase_text,"%S+") do
    n = n + 1
    text[n] = i
  end

  if n == 1 then
    font_size = 15
    x13 = x12
    y13 = y12 + spacing3
    displaytext(x13,y13,text[1],font,font_size,color)
  end
  if n == 2 then
    font_size = 13
    x13 = x12
    y13 = y12 + spacing3 -font_size
    displaytext(x13,y13,text[1],font,font_size,color)
    displaytext(x13,y13+font_size*1.1,text[2],font,font_size,color)
  end

  -- element4 (location,update)
  font = "Inconsolata"
  font_size = 16.5

  text = "Location: " .. location
  x14 = x + start4x
  y14 = y + start4y
  displaytext(x14,y14,text,font,font_size,color)

  font_size = 13.5
  text = "Last Update: " .. last_update
  x15 = x14
  y15 = y14 + spacing4
  displaytext(x15,y15,text,font,font_size,color)

  -- weather icon
  iconx = x + 160
  icony = y - 65
  iconpath = curdir .. "/image/weather_icons/" .. weather_icon_name(summary) ..".svg"
  iconname = "weather"
  iconsize = 81
  iconorig = 30
  draw_image(iconx,icony,iconpath,iconname,iconsize,iconorig,color6)
end

function weather_icon_name(weather)
  weather_icon_day_t = {
    Fair = "day-sunny",
    Clear = "day-sunny"
  }
  weather_icon_night_t = {
    Fair = "night-clear",
    Clear = "night-clear"
  }
  if 5 < tonumber(hours) and tonumber(hours) < 18  then
    return weather_icon_day_t[weather]
  else
    return weather_icon_night_t[weather]
  end
end
