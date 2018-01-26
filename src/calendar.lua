function calendar(x,y,calendar_size_x,calendar_size_y)
  local interval  = 600
  local year = tonumber(year)
  local month = tonumber(month)
  local day = tonumber(day)
  local luaday = 24*60*60

  dates = config.calendar.layout.dates
  column = config.calendar.layout.column
  row = config.calendar.layout.row


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
    os.execute(curdir.."/src/get_calendar.py &")
  end

  if timer == init then
    -- make calendar
    calendar_t = {}
    for i in range(1,column,1) do
      calendar_t[i] = {}
      for j in range(1,row,1) do
        calendar_t[i][j] = {}
      end
    end
    for i in range(1,dates,1) do
      local column = math.floor((i-1)/row)+1
      local row = i%row
      if row == 0 then
        row = 7
      end
      local date = os.date("%d",os.time()+i*luaday)
      table.insert(calendar_t[column][row],date)
    end
    -- open file
    local result = io.open(curdir.."/.tmp/events")
    if result ~= nil then
      for line in result:lines() do
        local event_year,event_month,event_day,event = line:match("(%d+)-(%d+)-(%d+)%s(.*)")
        local dist = (os.time({year=event_year,month=event_month,day=event_day}) - os.time({year=year,month=month,day=day}))/luaday
        if dist == 0 then
          today_event = event
        else
          local column = math.floor((dist-1)/row)+1
          local row = dist%row
          if row == 0 then
            row = 7
          end
          table.insert(calendar_t[column][row],event)
        end
      end
      result:close()
    else
      result:close()
    end
  end
  weeks_t = {}
  for weeks in range(1,weeks_in_month,1) do
    weeks_t[weeks] = {}
  end

  sizex = calendar_size_x or 520
  sizey = calendar_size_y or 250
  dayviewx = 120
  dayviewy = sizey
  datesx = sizex - dayviewx
  datesy = sizey
  yearmonthx = datesx
  yearmonthy = 35
  datesviewx = datesx
  datesviewy = datesy - yearmonthy
  dategridx = datesviewx / column
  dategridy = datesviewy / row

  lines_to_draw = {
    {x,y,sizex,0},
    {x,y,0,sizey},
    {x,y+sizey,sizex,0},
    {x+sizex,y,0,sizey},
    {x+dayviewx,y,0,dayviewy},
    {x+dayviewx,y+yearmonthy,yearmonthx,0}
  }
  draw_rel_lines(lines_to_draw)
  for i in range(1,row-1,1) do
    draw_rel_line(x+dayviewx,y+yearmonthy+dategridy*i,datesviewx,0)
  end
  for i in range(1,column-1,1) do
    draw_rel_line(x+dayviewx+dategridx*i,y+yearmonthy,0,datesviewy)
  end
  color = color8
  width = 0.5
  cairo_set_line_width(cr,width)
  cairo_set_source_rgba(cr,rgba(color))
  cairo_stroke(cr)

  do -- yearmonthview [Month Year]
    local text = month_name.."   "..tostring(year)
    local font = "Roboto"
    local font_size = 15
    local color = color5
    text_extents(text,font,font_size)
    local x = x + dayviewx + yearmonthx/2 - (extents.width/2 + extents.x_bearing)
    local y = y + yearmonthy/2 - (extents.height/2 + extents.y_bearing)
    displaytext(x,y,text,font,font_size,color)
  end


  do -- dayview
    do -- dayview_date
      local text = tostring(day)
      local font = "Roboto"
      local font_size = 60
      text_extents(text,font,font_size)
      local x = x + dayviewx/2 - (extents.width/2 + extents.x_bearing)
      local y = y + dayviewy/4.5 - (extents.height/2 + extents.y_bearing)
      local color = color5
      displaytext(x,y,text,font,font_size,color)
    end
    do -- dayview_month
      local font = "Roboto"
      local text = month_name_ab
      local font_size = 15
      text_extents(text,font,font_size)
      local x = x + dayviewx/2 - (extents.width/2 + extents.x_bearing) - 20
      local y = y + dayviewy/13 - (extents.height/2 + extents.y_bearing)
      local color = color5
      displaytext(x,y,text,font,font_size,color)
    end
    do -- dayview_weekday
      local font = "Roboto"
      local text = weekday_name_ab
      local font_size = 15
      text_extents(text,font,font_size)
      local x = x + dayviewx/2 - (extents.width/2 + extents.x_bearing) +20
      local y = y + dayviewy/2.8 - (extents.height/2 + extents.y_bearing)
      local color = color5
      displaytext(x,y,text,font,font_size,color)
    end
    do -- dayview_event
      local font = "Roboto"
      local text = event_today
      local font_size = 15
      text_extents(text,font,font_size)
      local x = x + dayviewx/2 - (extents.width/2 + extents.x_bearing)
      local y = y + dayviewy/2.0 - (extents.height/2 + extents.y_bearing)
      local color = color5
      displaytext(x,y,text,font,font_size,color)
    end
  end

  do -- datesview [Dates & weekdays & events]
    do -- dates
      local x = x + dayviewx
      local y = y + yearmonthy + dategridy/2
      for i in range(1,column,1) do
        local x = x + dategridx*(i-1)
        for j,k in ipairs(calendar_t[i]) do -- k = calendar_t[column][row]
          if k[1] == tostring(day) then
          else -- if not today
            do -- date
              local text = k[1]
              local font = "Roboto"
              local font_size = 12
              local color = color5
              text_extents(text,font,font_size)
              local x = x - (extents.width/2 + extents.x_bearing) + dategridx/9
              local y = y + (j-1)*dategridy - dategridy/9 - (extents.height/2 + extents.y_bearing)
              displaytext(x,y,text,font,font_size,color)
            end
            do -- event
              for l,event in ipairs(k) do
                -- events start from 2nd element
                if l == 1 then
                else
                  text1 = event
                  local font = "Source Han Sans JP"
                  local font_size = 10
                  local color = color5
                  text_extents(text1,font,font_size)
                  local x = x + dategridx/5
                  local y = y + dategridy*(j-1)- (extents.height/2 + extents.y_bearing) --+ dategridy/8
                  displaytext(x,y,text1,font,font_size,color)
                end
              end
            end
          end -- if k[1] == day
        end
      end
    end
    do -- weekdays
      local m = 0
      local n = 0
      local o = 0
      for i in range(1,dates,1) do
        local text = os.date("%a",os.time()+i*24*60*60) -- add i day
        local font = "Roboto"
        local font_size = 8
        local color = color5
        text_extents(text,font,font_size)
        local x = x + dayviewx + dategridx/9 + o - (extents.width/2 + extents.x_bearing)
        local y = y + yearmonthy + dategridy/1.35 + m - (extents.height/2 + extents.y_bearing)
        displaytext(x,y,text,font,font_size,color)
        m = m + dategridy
        n = n + 1
        if n % row == 0 then
          o = o + 1
          o = o*dategridx
          m = 0
        end
      end
    end
  end



end
