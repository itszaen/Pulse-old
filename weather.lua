function weather(x,y)
  interval = 60
  timer = (updates % interval)

  if timer == 0 or conky_start == 1 then
    file = io.open(curdir .. "/.tmp/weather")
    weather_t = {}
    for line in file:lines() do
      file_content = line
      table.insert(weather_t,file_content)
    end
    file:close()
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
  last_updated     = weather_t[18]
  icon             = weather_t[19]

  font = "Noto Sans"
  font_size = 80
  color = color6
  x1 = x
  y1 = y
  displaytext(x1,y1,temperature,font,font_size,color)

  font_size = 16
  text = temperature_high .. "/" .. temperature_low
  x2 = x + 80
  y2 = y + 20
  displaytext(x2,y2,text,font,font_size,color)


  x3 = x
  y3 = y + 20
  displaytext(x3,y3,summary,font,font_size,color)

  x4 = x
  y4 = y + 60
  displaytext(x4,y4,wind_speed,font,font_size,color)

  x5 = x
  y5 = y + 80
  displaytext(x5,y5,precip_chance,font,font_size,color)

end
