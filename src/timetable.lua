function classinfo(advance,wintertime,starttime)
  local hours = tonumber(hours)
  local minutes = tonumber(minutes)
  local seconds = tonumber(seconds)
  local wintertime = wintertime
  -- in seconds
  local curtime = hours*3600 + minutes*60 + seconds
  local advance = advance*60
  local starttime = starttime*60

  local timetable_file = config.info.class_update.file

  if conky_start == 1 then
    timetable_t = {{},{},{},{},{},{},{}}
    file = io.open(timetable_file)
    local weekday_n = 0 -- weekday
    for line in file:lines() do
      if line == "MONDAY" then
        weekday_n = 1
      elseif line == "TUESDAY" then
        weekday_n = 2
      elseif line == "WEDNESDAY" then
        weekday_n = 3
      elseif line == "THURSDAY" then
        weekday_n = 4
      elseif line == "FRIDAY" then
        weekday_n = 5
      elseif line == "SATURDAY" then
        weekday_n = 6
      elseif line == "SUNDAY" then
        weekday_n = 7
      else
        local st_h,st_m,et_h,et_m,classname = line:match("(%d+):(%d+)%s(%d+):(%d+)%s(.*)")
        local st_h,st_m,et_h,et_m = tonumber(st_h),tonumber(st_m),tonumber(et_h),tonumber(et_m)
        table.insert(timetable_t[weekday_n],{st_h,st_m,et_h,et_m,classname})
      end
    end
    file:close()
  end

  if config.info.class_update.vacation.enabled then
    if is_vacation() == 1 then
      return "Enjoy your summer vacation!",nil
    elseif is_vacation() == 2 then
      return "Enjoy your winter break!",nil
    elseif is_vacation() == 3 then
      return "Enjoy your spring rest!",nil
    end
  end
  if is_sunday() == 1 then
    return "It's your day off!",nil
  elseif is_school_finished(timetable_t,curtime,starttime) == 1 then
    return "School finished!",nil
  else
    class,timeinfo = get_classname(timetable_t,curtime,advance,wintertime)
    return class,timeinfo
  end
end
function get_classname(timetable_t,curtime,advance,wintertime)
  timetable_today_t = timetable_t[weekday_number]

  classtime_ins_t = {}
  classtime_start_ins_t = {}
  for i in ipairs(timetable_today_t) do
    classtime_start_ins = timetable_today_t[i][1]*3600 + timetable_today_t[i][2]* 60 + 0 - wintertime*60
    classtime_end_ins = timetable_today_t[i][3]*3600 + timetable_today_t[i][4]*60 + 0 - wintertime*60
    table.insert(classtime_ins_t,classtime_start_ins)
    table.insert(classtime_ins_t,classtime_end_ins)
    table.insert(classtime_start_ins_t,classtime_start_ins)
  end
  number = classnumber(classtime_start_ins_t,curtime,advance)
  now_classtime_ins = timetable_today_t[number][1]*3600+timetable_today_t[number][2]*60 + 0
  local timeinfo = countdown(now_classtime_ins,curtime)

  -- -- add all the class numbers before the day (not for Monday)
  -- if weekday_number >= 2 then
  --   local n = 0
  --   for i=1,weekday_number-1 do
  --     n = n + length_table(classtime_t[i])
  --   end
  --   number = number + n
  -- end

  class = timetable_today_t[number][5]

  return class,timeinfo
end

function is_sunday()
  weekday = tonumber(os.date("%w"))
  if weekday == 0 then
    return 1
  else
    return 0
  end
end
function is_vacation()
  local vacation = config.info.class_update.vacation
  if vacation.summer.enabled then
    local date = vacation.summer
    summer_vacation_t = {
      start  = {year=date.start[1],month=date.start[2],day=date.start[3]},
      finish = {year=date.finish[1],month=date.finish[2],day=date.finish[3]}
    }
    if os.time(summer_vacation_t["start"]) < os.time() and os.time() < os.time(summer_vacation_t["finish"]) then
      return 1
    end
  end
  if vacation.winter.enabled then
    local date = vacation.winter
    winter_vacation_t = {
      start  = {year=date.start[1],month=date.start[2],day=date.start[3]},
      finish = {year=date.finish[1],month=date.finish[2],day=date.finish[3]}
    }
    if os.time(winter_vacation_t["start"]) < os.time() and os.time() < os.time(winter_vacation_t["finish"]) then
    return 2
    end
  end
  if vacation.spring.enabled then
    local date = vacation.spring
    spring_vacation_t = {
      start  = {year=date.start[1],month=date.start[2],day=date.start[3]},
      finish = {year=date.finish[1],month=date.finish[2],day=date.finish[3]}
    }

    if os.time(spring_vacation_t["start"]) < os.time() and os.time() < os.time(spring_vacation_t["finish"]) then
      return 3
    else
      return 0
    end
  end
end
function is_school_finished(timetable_t,curtime,starttime)
  timetable_today_t = timetable_t[weekday_number]
  finishtime = table.remove(timetable_today_t)
  table.insert(timetable_today_t,finishtime) -- return the value back to the table
  finishtime_is = finishtime[3]*3600 + finishtime[4]*60 + 0
  if finishtime_is >= curtime and curtime >= starttime then
    return 0
  else
    return 1
  end
end

function classnumber(classtime_is_t,curtime,advance)
  modtime = curtime + advance
  class_number = within(classtime_is_t,modtime) -- on its weekday
  return class_number
end
function countdown(time,curtime)
  local countdown = time - curtime -- seconds
  if countdown <= 0 then
    countdown = "now"
  else
    countdown = second2Mmss(countdown,":")
  end
  return countdown
end
function within(T,number)
  for i in ipairs(T) do
    if number <= T[1] then
      return 1
    elseif T[i+1] == nil then
      return i
    elseif T[i] <= number and number <= T[i+1] then
      return i
    end
  end
end
