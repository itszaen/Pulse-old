dofile(curdir.."/src/drawimage.lua")

function weather(x,y)

  interval = 600
  timer = (updates % interval)
  area = config.weather.area

  if ic == 1 and (timer == 0 or conky_start == 1) then
    os.execute(curdir .. "/src/get_weather.py "..area.." &")
  end

  if timer == 0 or conky_start == 1 then
    local file = io.open(curdir .. "/.tmp/weather_" .. area)
    if file ~= nil then
      weather_t = {}
      for line in file:lines() do
        table.insert(weather_t,line)
      end
      file:close()
    else
      file:close()
    end
    local file = io.open(curdir .. "/.tmp/weather_forecasts_" .. area)
    if file ~= nil then
      forecast_t = {}
      for line in file:lines() do
        table.insert(forecast_t,line)
      end
      file:close()
    else
      file:close()
    end
  end

  if next(weather_t) == nil or next(forecast_t) == nil then
    return
  end

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

  second_date          = forecast_t[1]
  second_day_of_week   = forecast_t[2]
  second_temp_high     = forecast_t[3]
  second_temp_low      = forecast_t[4]
  second_humidity      = forecast_t[5]
  second_precip_chance = forecast_t[6]
  second_summary       = forecast_t[7]
  third_date           = forecast_t[8]
  third_day_of_week    = forecast_t[9]
  third_temp_high      = forecast_t[10]
  third_temp_low       = forecast_t[11]
  third_humidity       = forecast_t[12]
  third_precip_chance  = forecast_t[13]
  third_summary        = forecast_t[14]
  fourth_date          = forecast_t[15]
  fourth_day_of_week   = forecast_t[16]
  fourth_temp_high     = forecast_t[17]
  fourth_temp_low      = forecast_t[18]
  fourth_humidity      = forecast_t[19]
  fourth_precip_chance = forecast_t[20]
  fourth_summary       = forecast_t[21]

  --images
  if conky_start == 1 then
    store_weather_icons() -- except for the condition icon
  end
  -- condition images
  if timer == 0 or conky_start == 1 then
    store_weather_condition_icons()
  end
  -- location text

  location = code2area(area)

  do -- Display
    local font = "Roboto"
    local color = color6

    weather_icon_size = 50
    text_indent = iconsize + 15
    start1y = 35
    indent1 = 150
    local statsc_spacing = 42
    local statsc1x = x
    local statsc1y = y + 10
    spacing3 = spacing2
    local statsc2x = x + 150
    local statsc2y = y + 10
    local infox = x + 260
    local infoy = y -30
    local info_spacing = 25
    local forecastx = x + 275
    local forecasty = y + 45
    do -- temp [Temperature]
      local font = "Roboto"
      font_size = 80
      text = temperature
      text_extents(text,font,font_size)
      x1 = x + 40 - (extents.width + extents.x_bearing)*1/2
      y1 = y
      displaytext(x1,y1,text,font,font_size,color)
      iconx = x + 45
      icony = y - 100
      iconname = "celsius"
      iconsize = 165
      iconorig = 30
      draw_image(iconx,icony,iconname,iconsize,iconorig,color6)
    end
    do -- weathericon [Today's weather in an icon]
      iconx = x + 165
      icony = y - 60
      iconname = "weather"
      iconsize = 81
      iconorig = 30
      draw_image(iconx,icony,iconname,iconsize,iconorig,color6)
    end
    do -- highlowtemp [Highest/Lowest temperature]
      font_size = 17
      iconsize = 25
      iconorig = 30
      iconx = x + indent1
      icony = y + start1y - 18
      iconname = "thermometer"
      draw_image(iconx,icony,iconname,iconsize,iconorig,color6)
      text = temperature_high .. "/" .. temperature_low
      x2 = x + indent1 + text_indent - 15
      y2 = y + start1y
      displaytext(x2,y2,text,font,font_size,color)
    end
    do -- summary [Today's weather in one phrase]
        font_size = 18
        text = summary
        x3 = x + 10
        y3 = y2
        displaytext(x3,y3,text,font,font_size,color)
    end
    do -- stats [Statistics]
      local font_size = 14
      local spacing = statsc_spacing
      do -- statsc1 [Statistics 1st column]
        local x = statsc1x
        local y = statsc1y
        local indent = text_indent
        local offset = 25
        do -- humidity [Humidity]
          y = y + spacing
          iconname = "humidity"
          draw_image(x,y,iconname,40,30,color6)
          text = humidity
          local x = x + indent
          local y = y + offset
          displaytext(x,y,text,font,font_size,color)
        end
        do -- precip [Precipitaion chance]
          y = y + spacing
          iconname = "umbrella"
          draw_image(x,y,iconname,40,30,color6)
          text = precip_chance
          local x = x + indent
          local y = y + offset
          displaytext(x,y,text,font,font_size,color)
        end
        do -- wind [Wind speed]
          y = y + spacing
          iconname = "wind"
          draw_image(x,y,iconname,40,30,color6)
          text = wind_speed
          local x = x + indent
          local y = y + offset
          displaytext(x,y,text,font,font_size,color)
          end
        do -- airpressure [Air pressure]
          y = y + spacing
          iconname = "barometer"
          draw_image(x,y,iconname,40,30,color6)
          text = air_pressure
          local x = x + indent
          local y = y + offset
          displaytext(x,y,text,font,font_size,color)
        end
        do -- uv [Ultra Violet level]
          y = y + spacing
          uv_icon_offset = -3
          local y = y + uv_icon_offset
          iconname = "uv"
          draw_image(x,y,iconname,35,512,color6)
          text = uv_text
          local x = x + indent
          local y = y + offset
          displaytext(x,y,text,font,font_size,color)
        end
      end
      do -- statsc2 [Statistics 2nd column]
        local x = statsc2x
        local y = statsc2y
        local indent = text_indent
        local offset = 25
        do -- visibility [Visibility]
          y = y + spacing
          iconname = "visibility"
          draw_image(x,y,iconname,40,30,color6)
          text = visibility
          local x = x + indent
          local y = y + offset
          displaytext(x,y,text,font,font_size,color)
        end
        do -- dewpoint [Dew point]
          y = y + spacing
          iconname = "dewpoint"
          draw_image(x,y,iconname,40,30,color6)
          text = dew_point
          local x = x + indent
          local y = y + offset
          displaytext(x,y,text,font,font_size,color)
        end
        do -- sunrise [Sun rise time]
          y = y + spacing
          iconname = "sunrise"
          draw_image(x,y,iconname,40,30,color6)
          text = sunrise
          local x = x + indent
          local y = y + offset
          displaytext(x,y,text,font,font_size,color)
        end
        do -- sunset [Sun set time]
          y = y + spacing
          iconname = "sunset"
          draw_image(x,y,iconname,40,30,color6)
          text = sunset
          local x = x + indent
          local y = y + offset
          displaytext(x,y,text,font,font_size,color)
        end
        do -- moonphase [Moon phase]
          y = y + spacing
          local font = "Roboto"
          iconname = "moonphase"
          draw_image(x,y,iconname,40,30,color6)
          n = 0
          text = {}
          for i in string.gmatch(moon_phase_text,"%S+") do
            n = n + 1
            text[n] = i
          end
          if n == 1 then
            font_size = 15
            local x = x + indent
            local y = y + offset
            displaytext(x,y,text[1],font,font_size,color)
          end
          if n == 2 then
            font_size = 13
            local x = x + indent
            local y = y + offset - 7
            displaytext(x,y,text[1],font,font_size,color)
            displaytext(x,y+font_size*1.1,text[2],font,font_size,color)
          end
        end
      end
    end
    do -- info [Location, last update]
      local x = infox
      local y = infoy
      local font_size = 18
      local spacing = info_spacing
      local text = "Location: " .. location
      displaytext(x,y,text,font,font_size,color)

      local font_size = 13.5
      local text = "Last Update: " .. last_update
      local y = y + spacing
      displaytext(x,y,text,font,font_size,color)
    end
    do -- forecast [3 day forecasts]
      local x = forecastx
      local y = forecasty
      do -- title [Title]
        local text = "3 Day Forecasts"
        local width = 2
        local font_size = 16.5
        local length = 40
        local space = 5
        heading4(x,y,text,font,font_size,color,length,space,width,color)
      end
      local top = 5
      local left = 0
      local spacing = 70
      local spacing_text = 18
      local weather_icon_size = 65
      local weather_icon_offset = 8
      local text_indent = 65  -- from left
      local text_spacing = 25 -- from top
      local text_date_indent = 72
      local icon_offset = -15
      local icon_size = 20
      local text_icon_indent  = 50
      local text_icon_indent2 = 25
      local text_text_indent  = 18
      local text_text_indent2 = 20

      local font_size = 12
      do -- tmr [Tomorrow's forecast]
        do
          local y = y + weather_icon_offset
          draw_image(x,y,"weather2",weather_icon_size,30,color)
        end
        x2 = x + text_indent
        y2 = y + text_spacing
        text = second_day_of_week
        displaytext(x2,y2,text,font,font_size,color)
        x7 = x2 + text_date_indent
        y7 = y2
        text = second_date .. ":"
        displaytext(x7,y7,text,font,font_size,color)

        x3 = x2
        y3 = y2 + spacing_text
        text = second_summary
        displaytext(x3,y3,text,font,font_size,color)


        x4 = x3
        y4 = y3 + spacing_text
        text = second_temp_high .. "/" .. second_temp_low
        displaytext(x4,y4,text,font,font_size,color)

        iconx2 = x4 + text_icon_indent
        icony2 = y4 + icon_offset
        iconname = "humidity"
        draw_image(iconx2,icony2,iconname,icon_size,30,color)
        x5 = iconx2 + text_text_indent
        y5 = y4
        text = second_humidity
        displaytext(x5,y5,text,font,font_size,color)

        iconx3 = x5 + text_icon_indent2
        icony3 = y5 + icon_offset
        iconname = "umbrella"
        draw_image(iconx3,icony3,iconname,icon_size,30,color)
        x6 = iconx3 + text_text_indent2
        y6 = y5
        text = second_precip_chance
        displaytext(x6,y6,text,font,font_size,color)
      end
      local y = y + spacing
      do  -- datmr [Day after tomorrow's forecast]
        do
          local y = y + weather_icon_offset
          draw_image(x,y,"weather3",weather_icon_size,30,color)
        end
        x2 = x + text_indent
        y2 = y + text_spacing
        text = third_day_of_week
        displaytext(x2,y2,text,font,font_size,color)
        x7 = x2 + text_date_indent
        y7 = y2
        text = third_date .. ":"
        displaytext(x7,y7,text,font,font_size,color)

        x3 = x2
        y3 = y2 + spacing_text
        text = third_summary
        displaytext(x3,y3,text,font,font_size,color)

        x4 = x3
        y4 = y3 + spacing_text
        text = third_temp_high .. "/" .. third_temp_low
        displaytext(x4,y4,text,font,font_size,color)

        iconx2 = x4 + text_icon_indent
        icony2 = y4 + icon_offset
        iconname = "humidity"
        draw_image(iconx2,icony2,iconname,icon_size,30,color)
        x5 = iconx2 + text_text_indent2
        y5 = y4
        text = third_humidity
        displaytext(x5,y5,text,font,font_size,color)

        iconx3 = x5 + text_icon_indent2
        icony3 = y5 + icon_offset
        iconname = "umbrella"
        draw_image(iconx3,icony3,iconname,icon_size,30,color)
        x6 = iconx3 + text_text_indent2
        y6 = y5
        text = third_precip_chance
        displaytext(x6,y6,text,font,font_size,color)
      end
      local y = y + spacing
      do  -- tdatmr [2 Days after tomorrow's forecast]
        do
          local y = y + weather_icon_offset
          draw_image(x,y,"weather4",weather_icon_size,30,color)
        end
        x2 = x + text_indent
        y2 = y + text_spacing
        text = fourth_day_of_week
        displaytext(x2,y2,text,font,font_size,color)
        x7 = x2 + text_date_indent
        y7 = y2
        text = fourth_date .. ":"
        displaytext(x7,y7,text,font,font_size,color)

        x3 = x2
        y3 = y2 + spacing_text
        text = fourth_summary
        displaytext(x3,y3,text,font,font_size,color)

        x4 = x3
        y4 = y3 + spacing_text
        text = fourth_temp_high .. "/" .. fourth_temp_low
        displaytext(x4,y4,text,font,font_size,color)

        iconx2 = x4 + text_icon_indent
        icony2 = y4 + icon_offset
        iconname = "humidity"
        draw_image(iconx2,icony2,iconname,icon_size,30,color)
        x5 = iconx2 + text_text_indent
        y5 = y4
        text = fourth_humidity
        displaytext(x5,y5,text,font,font_size,color)

        iconx3 = x5 + text_icon_indent2
        icony3 = y5 + icon_offset
        iconname = "umbrella"
        draw_image(iconx3,icony3,iconname,icon_size,30,color)
        x6 = iconx3 + text_text_indent2
        y6 = y5
        text = fourth_precip_chance
        displaytext(x6,y6,text,font,font_size,color)
      end
    end
  end
end
function store_weather_icons()
  path = curdir .. "/image/weather_icons/celsius.svg"
  name = "celsius"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/thermometer.svg"
  name = "thermometer"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/humidity.svg"
  name = "humidity"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/umbrella.svg"
  name = "umbrella"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/windy.svg"
  name = "wind"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/barometer.svg"
  name = "barometer"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/uv.svg"
  name = "uv"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/smog.svg"
  name = "visibility"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/raindrops.svg"
  name = "dewpoint"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/sunrise.svg"
  name = "sunrise"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/sunset.svg"
  name = "sunset"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/moon-"..moon_phase..".svg"
  name = "moonphase"
  store_image(path,name)
end
function store_weather_condition_icons()
  ---print(summary,second_summary,third_summary,fourth_summary)
  path = curdir .. "/image/weather_icons/" .. weather_icon_name(summary) ..".svg"
  name = "weather"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/" .. forecast_icon_name(second_summary) .. ".svg"
  name = "weather2"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/" .. forecast_icon_name(third_summary) .. ".svg"
  name = "weather3"
  store_image(path,name)
  path = curdir .. "/image/weather_icons/" .. forecast_icon_name(fourth_summary) .. ".svg"
  name = "weather4"
  store_image(path,name)
end
function forecast_icon_name(weather)
  weather_icon_t = {
    ['Fair']  = "day-sunny",
    ['Clear'] = "day-sunny",
    ['Sunny'] = "day-sunny",
    ['Mostly Sunny'] = "day-sunny-overcast",
    ['Cloudy'] = "cloudy",
    ['Mostly Cloudy'] = "cloudy",
    ['Partly Cloudy'] = "cloud",
    ['Rain'] = "rain",
    ['Rain Shower'] = "rain",
    ['AM Rain'] = "rain",
    ['PM Rain'] = "rain",
    ['Showers'] = "showers",
    ['AM Showers'] = "showers",
    ['PM Showers'] = "showers",
    ['AM Light Rain'] = "showers",
    ['PM Light Rain'] = "showers",
    ['Snow'] = "snow",

    ['AM Clouds / PM Sun'] = "day-cloudy-high",
    ['Sunny / Wind'] = "day-windy",
    ['Fair / Windy'] = "day-windy",
    ['Mostly Cloudy / Windy'] = "cloudy-windy",
    ['Mostly Sunny / Wind'] = "day-windy",
    ['Rain / Snow'] = "rain-mix"
  }
  return weather_icon_t[weather]
end
function weather_icon_name(weather)
  weather_icon_day_t = {
    ['Fair'] = "day-sunny",
    ['Clear'] = "day-sunny",
    ['Fair / Windy'] = "day-windy",
    ['Mostly Sunny'] = "day-haze",
    ['Cloudy'] = "day-cloudy",
    ['Mostly Cloudy'] = "day-cloudy",
    ['Partly Cloudy'] = "day-cloudy",
    ['Rain'] = "day-rain",
    ['Rain Shower'] = "day-rain",
    ['Showers'] = "day-showers",
    ['Light Rain'] = "day-showers",
    ['Snow'] = "day-snow",
    ['Snow / Windy'] = "day-snow-wind",
    ['Mostly Cloudy / Windy'] = "day-cloudy-windy"
  }

  weather_icon_night_t = {
    ['Fair'] = "night-clear",
    ['Clear'] = "night-clear",
    ['Fair / Windy'] = "windy",
    ['Mostly Sunny'] = "night-clear",
    ['Cloudy'] = "cloudy",
    ['Mostly Cloudy'] = "cloudy",
    ['Partly Cloudy'] = "cloud",
    ['Rain'] = "night-rain",
    ['Rain Shower'] = "night-rain",
    ['Showers'] = "night-showers",
    ['Snow'] = "night-snow",
    ['Snow / Windy'] = "night-snow-wind",
    ['Light Rain'] = "night-showers",
    ['Mostly Cloudy / Windy'] = "night-cloudy-windy"
  }
  local hour_r, minute_r = sunrise:match('^(%d+):(%d+)')
  local hour_s, minute_s = sunset:match('^(%d+):(%d+)')
  local hour_s = hour_s + 12
  if os.time({year=tonumber(year),month=tonumber(month),day=tonumber(day),hour=tonumber(hour_r),minute=tonumber(minute_r)}) < os.time() and os.time() < os.time({year=tonumber(year),month=tonumber(month),day=tonumber(day),hour=tonumber(hour_s),minute=tonumber(minute_s)})  then
    return weather_icon_day_t[weather]
  else
    return weather_icon_night_t[weather]
  end
end
function code2area(code)
    location_t = {
    JAXX0001 = "Akita, Japan",
    JAXX0002 = "Akune, Japan",
    JAXX0003 = "Amagasaki, Japan",
    JAXX0004 = "Aomori, Japan",
    JAXX0005 = "Asahikawa, Japan",
    JAXX0006 = "Chiba, Japan",
    JAXX0007 = "Choshi, Japan",
    JAXX0008 = "Ebetsu, Japan",
    JAXX0009 = "Fukuoka, Japan",
    JAXX0010 = "Fukushima, Japan",
    JAXX0011 = "Funabashi, Japan",
    JAXX0012 = "Gifu, Japan",
    JAXX0013 = "Hachioji, Japan",
    JAXX0014 = "Hakodate, Japan",
    JAXX0015 = "Hakui, Japan",
    JAXX0016 = "East Osaka, Japan",
    JAXX0017 = "Himeji, Japan",
    JAXX0018 = "Hiroshima, Japan",
    JAXX0019 = "Hitachi, Japan",
    JAXX0020 = "Honjo, Japan",
    JAXX0021 = "Ichikawa, Japan",
    JAXX0022 = "Ichinomiya, Japan",
    JAXX0023 = "Iizuka, Japan",
    JAXX0024 = "Iwakuni, Japan",
    JAXX0025 = "Izumi, Japan",
    JAXX0026 = "Joetsu, Japan",
    JAXX0027 = "Kadena Air Base, Japan",
    JAXX0028 = "Kagoshima, Japan",
    JAXX0029 = "Kamiiso, Japan",
    JAXX0030 = "Kanazawa, Japan",
    JAXX0031 = "Karatsu, Japan",
    JAXX0032 = "Kariya, Japan",
    JAXX0033 = "Kashiwazaki, Japan",
    JAXX0034 = "Kasugai, Japan",
    JAXX0035 = "Kawaguchi, Japan",
    JAXX0036 = "Kawasaki, Japan",
    JAXX0037 = "Kisakata, Japan",
    JAXX0038 = "Kishiwada, Japan",
    JAXX0039 = "Kitakyushu, Japan",
    JAXX0040 = "Kobe, Japan",
    JAXX0041 = "Kofu, Japan",
    JAXX0042 = "Komatsu, Japan",
    JAXX0043 = "Kumamoto, Japan",
    JAXX0044 = "Kurashiki, Japan",
    JAXX0045 = "Kure, Japan",
    JAXX0046 = "Kurume, Japan",
    JAXX0047 = "Kyoto, Japan",
    JAXX0048 = "Machida, Japan",
    JAXX0049 = "Matsudo, Japan",
    JAXX0050 = "Nagano, Japan",
    JAXX0051 = "Matsuto, Japan",
    JAXX0052 = "Matsuyama, Japan",
    JAXX0053 = "Mito, Japan",
    JAXX0054 = "Nagaoka, Japan",
    JAXX0055 = "Nagasaki, Japan",
    JAXX0056 = "Nago, Japan",
    JAXX0057 = "Nagoya, Japan",
    JAXX0058 = "Naha, Japan",
    JAXX0059 = "Nanao, Japan",
    JAXX0060 = "Nara, Japan",
    JAXX0061 = "Niigata, Japan",
    JAXX0062 = "Noshiro, Japan",
    JAXX0063 = "Ogaki, Japan",
    JAXX0064 = "Okaya, Japan",
    JAXX0065 = "Okayama, Japan",
    JAXX0066 = "Okazaki, Japan",
    JAXX0067 = "Okinawa, Japan",
    JAXX0068 = "Omiya, Japan",
    JAXX0069 = "Omura, Japan",
    JAXX0070 = "Omuta, Japan",
    JAXX0071 = "Osaka, Japan",
    JAXX0072 = "Otaru, Japan",
    JAXX0073 = "Otsu, Japan",
    JAXX0074 = "Sagamihara, Japan",
    JAXX0075 = "Sakai, Japan",
    JAXX0076 = "Sakata, Japan",
    JAXX0077 = "Sanjo, Japan",
    JAXX0078 = "Sapporo, Japan",
    JAXX0079 = "Sasebo, Japan",
    JAXX0080 = "Shimonoseki, Japan",
    JAXX0081 = "Takamatsu, Japan",
    JAXX0082 = "Takaoka, Japan",
    JAXX0083 = "Takatsuki, Japan",
    JAXX0084 = "Tokuyama, Japan",
    JAXX0085 = "Tokyo, Japan",
    JAXX0086 = "Toyama, Japan",
    JAXX0087 = "Toyonaka, Japan",
    JAXX0088 = "Toyota, Japan",
    JAXX0089 = "Tsu, Japan",
    JAXX0090 = "Tsuruoka, Japan",
    USCA0638 = "Los Angeles, CA"
    }
    if location_t[code] ~= nil then
      area = location_t[code]
    else
      area = observation
    end
    return area
end
