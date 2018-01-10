function length_table(T)
  local n = 0
  for _ in pairs(T) do
    n = n + 1
  end
  return n
end
function second2hour_minute_second(time,separator)
  hour = round_float((time/3600),0)
  minute = time % 3600
  minute = round_float((minute/60),0)
  second = minute % 60
  if hour == 0 then
    ms = tostring(minute)..separator..tostring(second)
    return ms
  elseif hour == 0 and minute == 0 then
    s = tostring(second)
    return s
  else
    hms = tostring(hour)..separator..tostring(minute)..separator..tostring(second)
    return hms
  end
end
function second2Minute_second(time,separator)
  minute = round_float((time/60),0)
  second = minute % 60
  ms = tostring(minute)..separator..tostring(second)
  return ms
end
function round_float(num, numDecimalPlaces) --string
  rounded = string.format("%." .. (numDecimalPlaces or 0) .. "f", num) -- string
  return rounded
end
