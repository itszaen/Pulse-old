function classinfo()
  wintertime = 1

  if isSunday() == 1 then
    return "It's your day off!",0
  elseif isVacation() == 1 then
    return "Enjoy your summer vacation!",0
  elseif isVacation() == 2 then
    return "Enjoy your winter break!",0
  elseif isVacation() == 3 then
    return "Enjoy your spring rest!",0
  elseif isSchoolFinished() == 1 then
    return "School finished!",0
  else
    class = classname()
    return class,1
  end
end
function classname()
  advance = 20
  number = classnumber(hours,minutes,advance)
  if conky_start == 1 then
    file = io.open(curdir .. "/timetable.txt")
    class_table = {}
    for line in file:lines() do
      table.insert(class_table,line)
    end
    file:close()
  end
  class = class_table[number]
  return class
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

function classnumber(hour,minute,advance)
  curtime_n = hour*60 + minute
  time_n = curtime_n + advance

  if conky_start == 1 then
    if wintertime == 0 then
      classtime_t = {
        {8,10},{9,10},{10,10},{11,10},{12,40},{13,40},
        {8,10},{9,10},{10,10},{11,10},{12,40},{13,40},
        {8,10},{9,10},{10,10},{11,5},{11,40},{13,10},{14,10},
        {8,10},{9,10},{10,10},{11,10},{12,40},{13,40},
        {8,10},{9,10},{10,10},{11,10},{12,40},{13,40},
        {8,10},{9,10},{10,10},{11,10}
      }
    else
      classtime_t = {
        {8,20},{9,20},{10,20},{11,20},{12,50},{13,50},
        {8,20},{9,20},{10,20},{11,20},{12,50},{13,50},
        {8,20},{9,20},{10,20},{11,15},{11,50},{13,20},{14,20},
        {8,20},{9,20},{10,20},{11,20},{12,50},{13,50},
        {8,20},{9,20},{10,20},{11,20},{12,50},{13,50},
        {8,20},{9,20},{10,20},{11,20}
      }
    end
    classtime_n_t = {}
    for i in ipairs(classtime_t) do
      class_time_n = classtime_t[i][1] * 60 + classtime_t[i][2]
      table.insert(classtime_n_t,class_time_n)
    end
  end
  class_number = within(classtime_n_t,time_n)
  return class_number
end
function within(table1,number)
  for i in ipairs(table1) do
    if table1[i] <= number and number <= table1[i+1] then
      return i
    end
  end
end
