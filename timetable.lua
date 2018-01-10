function classinfo(advance,wintertime)
  if isVacation() == 1 then
    return "Enjoy your summer vacation!",nil
  elseif isVacation() == 2 then
    return "Enjoy your winter break!",nil
  elseif isVacation() == 3 then
    return "Enjoy your spring rest!",nil
  elseif isSunday() == 1 then
    return "It's your day off!",nil
  elseif isSchoolFinished() == 1 then
    return "School finished!",nil
  else
    class,time = classname(advance,wintertime)
    return class,time
  end
end
function classname(advance,wintertime)
  local hours = tonumber(hours)
  local minutes = tonumber(minutes)
  number,time = classnumber(hours,minutes,advance,wintertime)
  if conky_start == 1 then
    file = io.open(curdir .. "/timetable.txt")
    class_table = {}
    for line in file:lines() do
      table.insert(class_table,line)
    end
    file:close()
  end
  class = class_table[number]
  return class,time
end

function isSunday()
  weekday = tonumber(os.date("%w"))
  if weekday == 0 then
    return 1
  else
    return 0
  end
end
function isVacation()
  summer_vacation_t = {
    start  = {year=2017,month=7,day=13},
    finish = {year=2017,month=9,day=6}
  }
  winter_vacation_t = {
    start  = {year=2017,month=12,day=15},
    finish = {year=2018,month=1,day=9}
  }
  spring_vacation_t = {
    start  = {year=2018,month=3,day=10},
    finish = {year=2018,month=4,day=5}
  }

  if os.time(summer_vacation_t["start"]) < os.time() and os.time() < os.time(summer_vacation_t["finish"]) then
    return 1
  elseif os.time(winter_vacation_t["start"]) < os.time() and os.time() < os.time(winter_vacation_t["finish"]) then
    return 2
  elseif os.time(spring_vacation_t["start"]) < os.time() and os.time() < os.time(spring_vacation_t["finish"]) then
    return 3
  else
    return 0
  end
end
function isSchoolFinished()
  local hours = tonumber(hours)
  local weekday = tonumber(os.date("%w"))
  if weekday == 6 then
    if hours > 12 or hours < 3 then
      return 1
    else
      return 0
    end
  else
    if hours > 15 or hours < 3 then
      return 1
    else
      return 0
    end
  end
end

function classnumber(hour,minute,advance,wintertime)
  curtime_n = hour*60 + minute
  time_n = curtime_n + advance
  local weekday_n = tonumber(os.date("%w"))
  local seconds_n = tonumber(seconds)

  if conky_start == 1 then
    if wintertime == 0 then
      classtime_t = {
        {{8,10},{9,10},{10,10},{11,10},{12,40},{13,40}},
        {{8,10},{9,10},{10,10},{11,10},{12,40},{13,40}},
        {{8,10},{9,10},{10,10},{11,5},{11,40},{13,10},{14,10}},
        {{8,10},{9,10},{10,10},{11,10},{12,40},{13,40}},
        {{8,10},{9,10},{10,10},{11,10},{12,40},{13,40}},
        {{8,10},{9,10},{10,10},{11,10}}
      }
    else
      classtime_t = {
        {{8,20},{9,20},{10,20},{11,20},{12,50},{13,50}},
        {{8,20},{9,20},{10,20},{11,20},{12,50},{13,50}},
        {{8,20},{9,20},{10,20},{11,15},{11,50},{13,20},{14,20}},
        {{8,20},{9,20},{10,20},{11,20},{12,50},{13,50}},
        {{8,20},{9,20},{10,20},{11,20},{12,50},{13,50}},
        {{8,20},{9,20},{10,20},{11,20}}
      }
    end
    classtime_weekday_t = classtime_t[weekday_n]
    classtime_n_t = {}
    for i in ipairs(classtime_weekday_t) do
      class_time_n = classtime_weekday_t[i][1] * 60 + classtime_weekday_t[i][2]
      table.insert(classtime_n_t,class_time_n)
    end
  end
  class_number = within(classtime_n_t,time_n) -- on its weekday
  now_class_time_n = classtime_weekday_t[class_number][1]*60+classtime_weekday_t[class_number][2]
  if weekday >= 2 then
    local n = 0
    for i=1,weekday-1 do
      n = n + length_table(classtime_t[i])
    end
    class_number = class_number + n
  end
  time = now_class_time_n*60 - (curtime_n*60 + seconds_n) -- seconds
  if time <= 0 then
    time = "now"
  else
    time = second2Minute_second(time,":")
  end

  return class_number,time
end
function within(table1,number)
  for i in ipairs(table1) do
    if table1[i+1] == nil then
      break
    elseif table1[i] <= number and number <= table1[i+1] then
      return i
    end
  end
end
