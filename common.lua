function rgb_to_r_g_b(colour, alpha)
  return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end
function displaytext(x,y,text,font,font_size,color)
  font_slant  = CAIRO_FONT_SLANT_NORMAL
  font_weight = CAIRO_FONT_WEIGHT_NORMAL
  cairo_select_font_face(cr,font,font_slant,font_face)
  cairo_set_font_size(cr,font_size)
  cairo_set_source_rgba(cr,rgba(color))
  cairo_move_to(cr,x,y)
  cairo_show_text(cr,text)
  cairo_stroke(cr)
end
function text_extents(text,font,font_size)
  font_slant  = CAIRO_FONT_SLANT_NORMAL
  font_weight = CAIRO_FONT_WEIGHT_NORMAL
  cairo_select_font_face(cr,font,font_slant,font_face)
  cairo_set_font_size(cr,font_size)
  extents = cairo_text_extents_t:create()
  tolua.takeownership(extents)
  cairo_text_extents(cr,text,extents)
  -- Usage
  -- x = extents.width  + extents.x_bearing
  -- y = extents.height + extents.y_bearing
end
function rgba(color)
  r = color[1]
  g = color[2]
  b = color[3]
  a = color[4]
  return r,g,b,a
end
function draw_line(startx,starty,finishx,finishy)
  cairo_move_to (cr, startx , starty)
  cairo_line_to (cr, finishx, finishy)
  cairo_close_path(cr)
end
function draw_rel_line(startx,starty,movex,movey)
  cairo_move_to (cr, startx , starty)
  cairo_rel_line_to (cr, movex, movey)
  cairo_close_path(cr)
end
function draw_lines(T)
  for i in ipairs(T) do
  cairo_move_to(cr,T[i][1],T[i][2])
  cairo_line_to(cr,T[i][3],T[i][4])
  cairo_close_path(cr)
  end
end
function draw_rel_lines(T)
  for i in ipairs(T) do
    cairo_move_to(cr,T[i][1],T[i][2])
    cairo_rel_line_to(cr,T[i][3],T[i][4])
    cairo_close_path(cr)
  end
end


function length_table(T)
  local n = 0
  for _ in pairs(T) do
    n = n + 1
  end
  return n
end
function second2hour_minute_second(time,separator)
  hour = math.floor(time/3600)
  minute = time % 3600
  time = time % 3600
  minute = math.floor(minute/60)
  second = time % 60
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
function second2Mmss(time,separator)
  minute = math.floor(time/60)
  second = time % 60
  ms = string.format("%02d",minute)..separator..string.format("%02d",second)
  return ms
end
function round_float(num, numDecimalPlaces) --string
  rounded = string.format("%." .. (numDecimalPlaces or 0) .. "f", num) -- string
  return rounded
end
function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end
function get_days_in_month(month, year)
  local days_in_month = {31,28,31,30,31,30,31,31,30,31,30,31}
  local d = days_in_month[month]
  -- check for leap year
  if (month == 2) then
    if (math.mod(year,4) == 0) then
      if (math.mod(year,100) == 0)then
        if (math.mod(year,400) == 0) then
          d = 29
        end
      else
        d = 29
      end
    end
  end
  return d
end
function get_weeks_in_month(month,year)
  days = get_days_in_month(month,year)
  first = get_firstday_weekday_in_month(month,year)
  if (days==28 or days==29) and first == 1 then
    return 4
  else
    if (days==30 and first==7) or (days==31 and (first==6 or first==7)) then
      return 6
    else
      return 5
    end
  end
end
function get_firstday_weekday_in_month(month,year)
  return os.date("%w",os.time({year=tonumber(year),month=tonumber(month),day=1}))+1
end
function range(from, to, step)
  step = step or 1
  return function(_, lastvalue)
    local nextvalue = lastvalue + step
    if step > 0 and nextvalue <= to or step < 0 and nextvalue >= to or
      step == 0
    then
      return nextvalue
    end
  end, nil, from - step
end
function number2literal_ordinal_number(n)
  conversion_t = {
    "first","second","third","fourth","fifth","sixth","seventh","eighth","ninth","tenth","eleventh","twelfth","thirteenth","fourteenth","fifteenth","sixteenth","seventeenth","eighteenth","nineteenth","twentieth","twenty-first","twenty-second","twenty-third","twenty-fourth","twenty-fifth"
  }
  return conversion_t[n]
end
