#!/usr/bin/env python3
import pywapi
from os.path import expanduser
import datetime

time = datetime.datetime.now()
wc_result = pywapi.get_weather_from_weather_com('JAXX0085')

cur_cond = wc_result['current_conditions']
forecast = wc_result['forecasts']



temperature    = cur_cond['temperature']             + "℃"
temperature_high = forecast[1]['high']               + "℃"
temperature_low  = forecast[1]['low']                + "℃"
text           = cur_cond['text']
wind_speed     = cur_cond['wind']['speed']           + "km/h"
wind_gust      = cur_cond['wind']['gust']
wind_direction = cur_cond['wind']['direction']
visibility     = cur_cond['visibility']
precip_chance  = forecast[1]['day']['chance_precip'] + "%"
dew_point      = cur_cond['dewpoint']                + "℃"
humidity       = cur_cond['humidity']                + "%"
air_pressure   = cur_cond['barometer']['reading']    + "hPa"
uv_index       = cur_cond['uv']['index']
uv_text        = cur_cond['uv']['text']
sunrise_time   = forecast[1]['sunrise']
sunset_time    = forecast[1]['sunset']
moon_phase     = cur_cond['moon_phase']['icon']
last_updated   = cur_cond['last_updated']
icon           = cur_cond['icon']

list = [
    temperature,temperature_high,temperature_low,text,wind_speed,wind_gust,wind_direction,visibility,precip_chance,dew_point,humidity,air_pressure,uv_index,uv_text,sunrise_time,sunset_time,moon_phase,last_updated,icon
]
home = expanduser("~")
path = home + "/.config/conky/.tmp/weather"
file = open(path,'w+')
for i in range(len(list)):
    file.write(list[i]+'\n')
