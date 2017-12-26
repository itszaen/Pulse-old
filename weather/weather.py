#!/usr/bin/env python3
import pywapi
import pprint as pp
import os
import re
import datetime

time = datetime.datetime.now()
wc_result = pywapi.get_weather_from_weather_com('JAXX0085')

cur_cond = wc_result['current_conditions']

weather = {
    'TMP' : cur_cond['temperature'] + "℃",
    'HUM' : cur_cond['humidity']    + "%",
    'BAR' : cur_cond['barometer']['reading'] + 'mb',
    'WND' : (wind['speed'] + ' km/h from ' + wind['text']) if wind['speed'] != 'calm' else wind['text'],
    'CPR' : forcast[0]['day']['chance_precip'] + "%"
}
