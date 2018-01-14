function calendar(x,y,calendar_size_x,calendar_size_y)
  local interval  = 600
  local year = tonumber(year)
  local month = tonumber(month)
  local day = tonumber(day)

  days_in_month = get_days_in_month(month,year)
  weeks_in_month = get_weeks_in_month(month,year)
  firstday_weekday = get_firstday_weekday_in_month(tonumber(month),tonumber(year)) -- sun = 1 ~ sat = 7

  if io.open(curdir.."/.tmp/events") ~= nil then
    init = 2
  else
    init = 20
  end
  local spacing = 1
  local font_size = 15
  local color = color5
  timer  = (updates % interval)


  if ic == 1 and (timer == 0 or conky_start) then
    os.execute(curdir.."/getcalendar.py &")
  end

  if timer == init then
    -- make calendar
    calendar_t = {}
    for i in range(1,weeks_in_month,1) do
      calendar_t[i] = {}
      for j in range(1,7,1) do
        calendar_t[i][j] = {}
      end
    end
    for i in range(1,days_in_month,1) do
      local modday = i + (firstday_weekday-1)
      local week = math.floor(modday/7) + 1
      local th = modday % 7
      if th == 0 then
        week = week - 1
        th = 7
      end
      table.insert(calendar_t[week][th],tostring(i))
    end
    -- open file
    local result = io.open(curdir.."/.tmp/events")
    if result ~= nil then
      for line in result:lines() do
        local day = tonumber(line:match("%d+"))
        local modday = day + firstday_weekday-1
        local week = math.floor(modday/7)+1
        local th = modday % 7
        if th == 0 then
          th = 7
        end
        local event = trim(line:match("%s.*"))
        table.insert(calendar_t[week][th],event)
      end
      result:close()
    else
      result:close()
    end
  end
  weekname_t = {"SUN","MON","TUE","WED","THU",'FRI',"SAT"}
  weeks_t = {}
  for weeks in range(1,weeks_in_month,1) do
    weeks_t[weeks] = {}
  end

  sizex = calendar_size_x or 570
  sizey = calendar_size_y or 280
  dayviewx = 120
  dayviewy = sizey
  datesx = sizex - dayviewx
  datesy = sizey
  yearmonthx = datesx
  yearmonthy = 35
  weekdaysviewx = datesx
  weekdaysviewy = 20
  datesviewx = datesx
  datesviewy = datesy - yearmonthy - weekdaysviewy
  dategridx = datesviewx / 7
  dategridy = datesviewy / weeks_in_month

  lines_to_draw = {
    {x,y,sizex,0},
    {x,y,0,sizey},
    {x,y+sizey,sizex,0},
    {x+sizex,y,0,sizey},
    {x+dayviewx,y,0,dayviewy},
    {x+dayviewx,y+yearmonthy+weekdaysviewy,weekdaysviewx,0},
    {x+dayviewx,y+yearmonthy,yearmonthx,0}
  }
  draw_rel_lines(lines_to_draw)
  for i in range(1,weeks_in_month-1,1) do
    draw_rel_line(x+dayviewx,y+yearmonthy+weekdaysviewy+dategridy*i,datesx,0)
  end
  for i in range(1,7-1,1) do
    draw_rel_line(x+dayviewx+dategridx*i,y+yearmonthy,0,weekdaysviewy+datesviewy)
  end
  color = color8
  width = 0.5
  cairo_set_line_width(cr,width)
  cairo_set_source_rgba(cr,rgba(color))
  cairo_stroke(cr)

  do
    local text = month_name.."   "..tostring(year)
    local font = "Roboto"
    local font_size = 15
    local color = color5
    text_extents(text,font,font_size)
    local x = x + dayviewx + yearmonthx/2 - (extents.width/2 + extents.x_bearing)
    local y = y + yearmonthy/2 - (extents.height/2 + extents.y_bearing)
    displaytext(x,y,text,font,font_size,color)
  end

  local n = 0
  for _,weekname in ipairs(weekname_t) do
    local text = weekname
    local font = "Roboto"
    local font_size = 12
    local color = color5
    text_extents(text,font,font_size)
    local x = x + dayviewx + dategridx/2 + n - (extents.width/2 + extents.x_bearing)
    local y = y + yearmonthy + weekdaysviewy/2 - (extents.height/2 + extents.y_bearing)
    displaytext(x,y,text,font,font_size,color)
    n = n + dategridx
  end
  do
    local text = tostring(day)
    local font = "Roboto"
    local font_size = 60
    text_extents(text,font,font_size)
    local x = x + dayviewx/2 - (extents.width/2 + extents.x_bearing)
    local y = y + dayviewy/4.5 - (extents.height/2 + extents.y_bearing)
    local color = color5
    displaytext(x,y,text,font,font_size,color)
  end
  do
    local font = "Roboto"
    local text = month_name_ab
    local font_size = 15
    text_extents(text,font,font_size)
    local x = x + dayviewx/2 - (extents.width/2 + extents.x_bearing) - 20
    local y = y + dayviewy/13 - (extents.height/2 + extents.y_bearing)
    local color = color5
    displaytext(x,y,text,font,font_size,color)
  end
  do
    local font = "Roboto"
    local text = weekday_name_ab
    local font_size = 15
    text_extents(text,font,font_size)
    local x = x + dayviewx/2 - (extents.width/2 + extents.x_bearing) +20
    local y = y + dayviewy/2.8 - (extents.height/2 + extents.y_bearing)
    local color = color5
    displaytext(x,y,text,font,font_size,color)
  end

  if weeks_in_month == 4 then
  elseif weeks_in_month == 5 then
    date_numberx = x + dayviewx + dategridx/2
    date_numbery = y + yearmonthy + weekdaysviewy + dategridy/2
    for i in ipairs(calendar_t) do
      date_number_weeky = date_numbery + dategridy*(i-1)
      for j,k in ipairs(calendar_t[i]) do
        if k[1] == tostring(day) then
          cairo_rectangle(cr,x+dayviewx+dategridx*(j-1),y+yearmonthy+weekdaysviewy+dategridy*(i-1),dategridx,dategridy)
          color = purple_dark
          cairo_set_source_rgba(cr,rgba(color))
          cairo_fill(cr)

          local text = k[1]
          local font = "Roboto"
          local font_size = 14
          local color = color7
          text_extents(text,font,font_size)
          local x1 = date_numberx + dategridx*(j-1) - (extents.width/2 + extents.x_bearing) + dategridx/3.6
          local y1 = date_number_weeky - (extents.height/2 + extents.y_bearing) - dategridy/4
          displaytext(x1,y1,text,font,font_size,color)
        else
          do
            local text = k[1]
            local font = "Roboto"
            local font_size = 12
            local color = color5
            text_extents(text,font,font_size)
            local x = date_numberx + dategridx*(j-1) - (extents.width/2 + extents.x_bearing) + dategridx/3.5
            local y = date_number_weeky - (extents.height/2 + extents.y_bearing) - dategridy/4
            displaytext(x,y,text,font,font_size,color)
          end
          do
            for l,event in ipairs(k) do
              -- events start from 2nd element
              if l == 1 then
                text = nil
              else
                _G["event"..l] = event
                text1 = event--_G["event"..l]:match("%S+")
                local font = "Source Han Sans JP"
                local font_size = 10
                local color = color5
                text_extents(text1,font,font_size)
                local x = date_numberx + dategridx*(j-1) - (extents.width/2 + extents.x_bearing)
                local y = date_number_weeky - (extents.height/2 + extents.y_bearing) --+ dategridy/8
                displaytext(x,y,text1,font,font_size,color)
              end
            end
          end
        end -- if k[1] == day
      end
    end
  elseif weeks_in_month == 6 then
  else
  end



end
