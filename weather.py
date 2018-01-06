#!/usr/bin/env python3
import pywapi
import sys
from os.path import expanduser
import datetime


time = datetime.datetime.now()
wc_result = pywapi.get_weather_from_weather_com(sys.argv[1])

cur_cond = wc_result['current_conditions']
forecast = wc_result['forecasts']

#Today

temperature    = cur_cond['temperature']
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
location       = cur_cond['station']
moon_phase_text= cur_cond['moon_phase']['text']

list = [
    temperature,temperature_high,temperature_low,text,wind_speed,wind_gust,wind_direction,visibility,precip_chance,dew_point,humidity,air_pressure,uv_index,uv_text,sunrise_time,sunset_time,moon_phase,last_updated,location,moon_phase_text
]

home = expanduser("~")
areacode = sys.argv[1]

def output_weather():
    path = home + "/.config/conky/.tmp/weather_" + areacode
    file = open(path,'w+')
    for i in range(len(list)):
        file.write(list[i]+'\n')

# Forecasts (1 week) (day)
def output_forecasts():
    path = home + "/.config/conky/.tmp/weather_forecasts_" + areacode
    file = open(path,'w+')
    for i in range(2,5):
        file.write(forecast[i]['date']                 + '\n')
        file.write(forecast[i]['day_of_week']          + '\n')
        file.write(forecast[i]['high']                 + '℃' + '\n')
        file.write(forecast[i]['low']                  + '℃' + '\n')
        file.write(forecast[i]['day']['humidity']      + '%' + '\n')
        file.write(forecast[i]['day']['chance_precip'] + '%' + '\n')
        file.write(forecast[i]['day']['text']          + '\n')

def main():
    output_weather()
    output_forecasts()

if __name__ == '__main__':
    main()
