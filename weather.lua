function weather()
  temperature_tokyo = conky_parse("${weather http://tgftp.nws.noaa.gov/data/observations/metar/stations/ RJTF temperature}")
  print(temperature_tokyo)
end
