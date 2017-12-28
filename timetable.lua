function classinfo()
  if isSunday() == 1 then
    return "It's your day off!"
  elseif isVacation() == 1 then
    return "Enjoy your summer vacation!"
  elseif isVacation() == 2 then
    return "Enjoy your winter break!"
  elseif isVacation() == 3 then
    return "Enjoy your spring rest!"
  elseif isSchoolFinished() == 1 then
    return "School finished!"
  else
    class = classname()
    text = class
    return text
  end
end
function classname()
  number = classnumber(hour,minutes,20)
  if conky_start == 1 then
  file = io.open(curdir .. "/timetable.txt")
  class_table = {}
  for line in file:lines() do
    file_content = line
    table.insert(class_table,file_content)
  end
  file:close()
  end
  class = class_table[number]
  return class
end

function isSunday()
  weekday = os.date("%w")
  if weekday == 0 then
    return 1
  else
    return 0
  end
end
function isVacation()
  if month == 7 then
    return 1
  elseif month == 12 then
    return 2
  elseif month == 3 then
    return 3
  else
    return 0
  end
end
function isSchoolFinished()
  if os.date("%w") == 6 then
    if hours > 12 or hours < 3 then
      return 1
    else
      return 0
    end
    if hours > 15 or hours < 3 then
      return 1
    else
      return 0
    end
  end
end

function classnumber(hour,minute,advance)
  curtime = hours*60 + minute
  time = curtime + advance
  if winter == 0 then
    classtime = {
      {8,10},{9,10},{10,10},{11,10},{12,40},{13,40},
      {8,10},{9,10},{10,10},{11,10},{12,40},{13,40},
      {8,10},{9,10},{10,10},{11,5},{11,40},{13,10},{14,10},
      {8,10},{9,10},{10,10},{11,10},{12,40},{13,40},
      {8,10},{9,10},{10,10},{11,10},{12,40},{13,40},
      {8,10},{9,10},{10,10},{11,10}
    }
  else
    classtime = {
      {8,20},{9,20},{10,20},{11,20},{12,50},{13,50},
      {8,20},{9,20},{10,20},{11,20},{12,50},{13,50},
      {8,20},{9,20},{10,20},{11,15},{11,50},{13,20},{14,20},
      {8,20},{9,20},{10,20},{11,20},{12,50},{13,50},
      {8,20},{9,20},{10,20},{11,20},{12,50},{13,50},
      {8,20},{9,20},{10,20},{11,20}
    }
  end
  for i in ipairs(classtime) do
    class_time = classtime[i][1] * 60 + classtime[i][2]
    if time > class_time then
      return i
    end
  end
end
