function classinfo(advance,wintertime)
  local hours = tonumber(hours)
  local minutes = tonumber(minutes)
  local seconds = tonumber(seconds)

  curtime = hours*3600 + minutes*60 + seconds -- in seconds
  advance = advance*60 -- in seconds
  starttime = 6 * 3600 + 0 * 60 + 0

  if conky_start == 1 then
    file = io.open(curdir .. "/timetable.txt")
    classname_t = {}
    for line in file:lines() do
      table.insert(classname_t,line)
    end
    file:close()
  end
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
  end

  if isVacation() == 1 then
    return "Enjoy your summer vacation!",nil
  elseif isVacation() == 2 then
    return "Enjoy your winter break!",nil
  elseif isVacation() == 3 then
    return "Enjoy your spring rest!",nil
  elseif isSunday() == 1 then
    return "It's your day off!",nil
  elseif isSchoolFinished(classtime_t,curtime,starttime) == 1 then
    return "School finished!",nil
  else
    class,countdown = classname(classname_t,classtime_t,curtime,advance)
    return class,countdown
  end
end
function classname(classname_t,classtime_t,curtime,advance)
  class = classname_t[number]

  classtime_in_seconds_t = {}
  for i in ipairs(classtime_weekday_t) do
    classtime_in_seconds = classtime_weekday_t[i][1]*3600 + classtime_weekday_t[i][2]* 60 + 0
    table.insert(classtime_in_seconds_t,classtime_in_seconds)
  end

  classtime_weekday_t = classtime_t[weekday_number]

  number = classnumber(classtime_t,classtime_in_seconds_t,curtime,advance)
  now_classtime_in_second = classtime_weekday_t[class_number][1]*3600+classtime_weekday_t[class_number][2]*60 + 0
  countdown = countdown(now_classtime_in_second)
  return class,countdown
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
function isSchoolFinished(timetable_t,curtime,starttime)
  classtime_weekday_t = classtime_t[weekday_number]
  finishtime = table.remove(classtime_weekday_t)
  table.insert(classtime_weekday_t,finishtime) -- return the value back to the table
  finishtime_in_seconds = finishtime[1]*3600 + finishtime[2]*60 + 0
  if finishtime_in_seconds <= curtime and curtime >= starttime then
    return 0
  else
    return 1
  end
end

function classnumber(classtime_t,classtime_in_seconds_t,curtime,advance)
  modtime = curtime + advance
  class_number = within(classtime_in_seconds_t,modtime) -- on its weekday

  -- add all the class numbers before the day (not for Monday)
  if weekday_number >= 2 then
    local n = 0
    for i=1,weekday_number-1 do
      n = n + length_table(classtime_t[i])
    end
    class_number = class_number + n
  end
  return class_number
end
function countdown(time)
  countdown = time - curtime -- seconds
  if countdown <= 0 then
    countdown = "now"
  else
    countdown = second2Mmss(time,":")
  end
end
function within(T,number)
  for i in ipairs(T) do
    if number <= T[1] then
      return 1
    elseif T[i+1] == nil then
      break
    elseif T[i] <= number and number <= T[i+1] then
      return i
    end
  end
end
