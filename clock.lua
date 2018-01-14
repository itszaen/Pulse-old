require 'logo'

function clock(x,y)
  clockx = x
  clocky = y
  clocksize = center
  inner = 50
  digital_t = 0
  logosize = 60
  logox = clockx + 0
  logoy = clocky -120
  cairo_set_operator(cr,CAIRO_OPERATOR_SOURCE)

  if digital_t == 1 then
    digital_date()
    digital_time()
    innerline()
  else end

  watch_dial()
  dig_date02()
  archlogo(logox,logoy,logosize)
  analog_time()
end


function analog_time()
  if conky_start == 1 then
    store_image(curdir.."/image/Sword.svg","sword")
  end

  hour_degree = hours12*360/12 + minutes*360/720 + seconds*360/43200 -90
  minute_degree = minutes*360/60 + seconds*360/3600 -90
  second_degree = seconds*360/60 -90
  hour_length = 0.5
  minute_length = 0.8
  second_length = 1.0
  watch_hand_hour(hour_degree,hour_length)
  watch_hand_minute(minute_degree,minute_length)
  --if second_degree ~= 90 then
  watch_hand_second_1(second_degree,second_length)
  --else
  --  watch_hand_second_2(second_degree,second_length)
  --end
  watch_hand_pin()
end
--[[function watch_hand(degree,width,ratio)
  size = clocksize
  local color = color1
  sx = clockx
  sy = clocky
  fx = sx + ratio*(math.cos(degree*math.pi/180)*(size/2-25))
  fy = sy + ratio*(math.sin(degree*math.pi/180)*(size/2-25))
  cairo_set_line_width (cr,width)
  cairo_set_source_rgba (cr,rgba(color))
  draw_line(sx,sy,fx,fy)
  cairo_stroke(cr)
  end]]
function watch_hand_pin()
  outercolor = color4
  outerradius = 10
  middlecolor = color2
  middleradius = 7
  innercolor = color1
  innerradius = 4
  cairo_set_line_width(cr,1)
  cairo_set_source_rgba(cr,rgba(outercolor))
  cairo_arc(cr,clockx,clocky,outerradius,0,2*math.pi)
  cairo_fill(cr)
  cairo_set_source_rgba(cr,rgba(middlecolor))
  cairo_arc(cr,clockx,clocky,outerradius,0,2*math.pi)
  cairo_fill(cr)
  cairo_set_source_rgba(cr,rgba(innercolor))
  cairo_arc(cr,clockx,clocky,innerradius,0,2*math.pi)
  cairo_fill(cr)
end
function watch_hand_hour(degree,scale)
 size = clocksize
  length = size/2-25
  sx = clockx
  sy = clocky
  offset1 = length/5
  offset2 = length/4
  offset3 = length/1.5
  rootwidth = 7.5
  outerwidth = 15
  innerwidth = 10
  endwidth = 0.2
  outercolor = color4
  innercolor = color2
  lx = sx+(math.cos((degree+rootwidth)*math.pi/180)*offset1)*scale
  ly = sy+(math.sin((degree+rootwidth)*math.pi/180)*offset1)*scale
  mx = sx+(math.cos((degree-rootwidth)*math.pi/180)*offset1)*scale
  my = sy+(math.sin((degree-rootwidth)*math.pi/180)*offset1)*scale
  nx = sx+(math.cos((degree+outerwidth)*math.pi/180)*offset2)*scale
  ny = sy+(math.sin((degree+outerwidth)*math.pi/180)*offset2)*scale
  ox = sx+(math.cos((degree-outerwidth)*math.pi/180)*offset2)*scale
  oy = sy+(math.sin((degree-outerwidth)*math.pi/180)*offset2)*scale
  px = sx+(math.cos((degree+endwidth)*math.pi/180)*length)*scale
  py = sy+(math.sin((degree+endwidth)*math.pi/180)*length)*scale
  qx = sx+(math.cos((degree-endwidth)*math.pi/180)*length)*scale
  qy = sy+(math.sin((degree-endwidth)*math.pi/180)*length)*scale
  cairo_set_line_width(cr,1)
  cairo_set_source_rgba(cr,rgba(outercolor))
  cairo_move_to(cr,sx,sy)
  cairo_line_to(cr,lx,ly)
  cairo_line_to(cr,nx,ny)
  cairo_line_to(cr,px,py)
  cairo_line_to(cr,qx,qy)
  cairo_line_to(cr,ox,oy)
  cairo_line_to(cr,mx,my)
  cairo_line_to(cr,sx,sy)
  cairo_close_path(cr)
  cairo_fill(cr)
  rx = sx+(math.cos(degree*math.pi/180)*offset1)*scale
  ry = sy+(math.sin(degree*math.pi/180)*offset1)*scale
  tx = sx+(math.cos((degree+innerwidth)*math.pi/180)*offset2)*scale
  ty = sy+(math.sin((degree+innerwidth)*math.pi/180)*offset2)*scale
  ux = sx+(math.cos((degree-innerwidth)*math.pi/180)*offset2)*scale
  uy = sy+(math.sin((degree-innerwidth)*math.pi/180)*offset2)*scale
  vx = sx+(math.cos(degree*math.pi/180)*offset3)*scale
  vy = sy+(math.sin(degree*math.pi/180)*offset3)*scale
  cairo_set_line_width(cr,linewidth)
  cairo_set_source_rgba(cr,rgba(innercolor))
  cairo_move_to(cr,rx,ry)
  cairo_line_to(cr,tx,ty)
  cairo_line_to(cr,vx,vy)
  cairo_line_to(cr,ux,uy)
  cairo_line_to(cr,rx,ry)
  cairo_close_path(cr)
  cairo_fill(cr)
end
function watch_hand_minute(degree,scale)
  size = clocksize
  length = size/2-25
  sx = clockx
  sy = clocky
  offset1 = length/5
  offset2 = length/4
  offset3 = length/1.5
  rootwidth = 6
  outerwidth = 12
  innerwidth = 7.2
  endwidth = 0.2
  outercolor = color4
  innercolor = color2
  lx = sx+(math.cos((degree+rootwidth)*math.pi/180)*offset1)*scale
  ly = sy+(math.sin((degree+rootwidth)*math.pi/180)*offset1)*scale
  mx = sx+(math.cos((degree-rootwidth)*math.pi/180)*offset1)*scale
  my = sy+(math.sin((degree-rootwidth)*math.pi/180)*offset1)*scale
  nx = sx+(math.cos((degree+outerwidth)*math.pi/180)*offset2)*scale
  ny = sy+(math.sin((degree+outerwidth)*math.pi/180)*offset2)*scale
  ox = sx+(math.cos((degree-outerwidth)*math.pi/180)*offset2)*scale
  oy = sy+(math.sin((degree-outerwidth)*math.pi/180)*offset2)*scale
  px = sx+(math.cos((degree+endwidth)*math.pi/180)*length)*scale
  py = sy+(math.sin((degree+endwidth)*math.pi/180)*length)*scale
  qx = sx+(math.cos((degree-endwidth)*math.pi/180)*length)*scale
  qy = sy+(math.sin((degree-endwidth)*math.pi/180)*length)*scale
  cairo_set_line_width(cr,1)
  cairo_set_source_rgba(cr,rgba(outercolor))
  cairo_move_to(cr,sx,sy)
  cairo_line_to(cr,lx,ly)
  cairo_line_to(cr,nx,ny)
  cairo_line_to(cr,px,py)
  cairo_line_to(cr,qx,qy)
  cairo_line_to(cr,ox,oy)
  cairo_line_to(cr,mx,my)
  cairo_line_to(cr,sx,sy)
  cairo_close_path(cr)
  cairo_fill(cr)
  rx = sx+(math.cos(degree*math.pi/180)*offset1)*scale
  ry = sy+(math.sin(degree*math.pi/180)*offset1)*scale
  tx = sx+(math.cos((degree+innerwidth)*math.pi/180)*offset2)*scale
  ty = sy+(math.sin((degree+innerwidth)*math.pi/180)*offset2)*scale
  ux = sx+(math.cos((degree-innerwidth)*math.pi/180)*offset2)*scale
  uy = sy+(math.sin((degree-innerwidth)*math.pi/180)*offset2)*scale
  vx = sx+(math.cos(degree*math.pi/180)*offset3)*scale
  vy = sy+(math.sin(degree*math.pi/180)*offset3)*scale
  cairo_set_line_width(cr,linewidth)
  cairo_set_source_rgba(cr,rgba(innercolor))
  cairo_move_to(cr,rx,ry)
  cairo_line_to(cr,tx,ty)
  cairo_line_to(cr,vx,vy)
  cairo_line_to(cr,ux,uy)
  cairo_line_to(cr,rx,ry)
  cairo_close_path(cr)
  cairo_fill(cr)
end
function watch_hand_second_1(degree,scale)
  size = clocksize
  sx = clockx
  sy = clocky
  radius = 2.5
  color = color2
  startwidth = 4
  endwidth = 0.2
  gap = 0.95
  lx = scale*(math.cos(degree*math.pi/180)*(size/2-25))
  ly = scale*(math.sin(degree*math.pi/180)*(size/2-25))
  mx = scale*(math.cos((degree-startwidth)*math.pi/180)*(size/2-25))*gap
  my = scale*(math.sin((degree-startwidth)*math.pi/180)*(size/2-25))*gap
  nx = scale*(math.cos((degree+startwidth)*math.pi/180)*(size/2-25))*gap
  ny = scale*(math.sin((degree+startwidth)*math.pi/180)*(size/2-25))*gap
  ox = scale*(math.cos((degree+endwidth)*math.pi/180)*(size/2-25))
  oy = scale*(math.sin((degree+endwidth)*math.pi/180)*(size/2-25))
  px = scale*(math.cos((degree-endwidth)*math.pi/180)*(size/2-25))
  py = scale*(math.sin((degree-endwidth)*math.pi/180)*(size/2-25))
  cairo_set_line_width(cr,1)
  cairo_set_source_rgba(cr,rgba(color))
  cairo_arc(cr,sx,sy,radius,0,2*math.pi)
  cairo_move_to(cr,sx-lx*0.2,sy-ly*0.2)
  cairo_line_to(cr,sx-mx*0.2,sy-my*0.2)
  cairo_line_to(cr,sx+ox,sy+oy)
  cairo_line_to(cr,sx+px,sy+py)
  cairo_line_to(cr,sx-nx*0.2,sy-ny*0.2)
  cairo_line_to(cr,sx-lx*0.2,sy-ly*0.2)
  cairo_close_path(cr)
  cairo_fill(cr)
end
function watch_hand_second_2(degree,scale)
  cairo_arc(cr,clockx,clocky,2,0,2*math.pi)
  cairo_fill(cr)
  sx = clockx
  sy = clocky
  degree = degree
  offset = 700
  offsetx = offset - 59 + 267 + 36
  offsety = offset - 275
  --memo
  -- size 267/267
  --(640,425) opposite
  --(944,425) now
  name = "sword"
  size = 168
  original = 267
  draw_image_polar(sx,sy,degree,offsetx,offsety,name,size,original,color)
end
function watch_dial()
  thick = 6
  normal = 3
  thin = 1
  for i=0,359,6 do
    if i%90 == 0 then
      width = thick
      alpha = 0.8
    elseif i%30 == 0 then
      width = normal
      alpha = 0.6
    else
      width = thin
      alpha = 0.3
    end
    watch_dial_line(i,width,alpha)
  end
end
function innerline()
  width = 5
  red = 0.68
  green = 0.68
  blue = 1.0
  alpha = 0.1
  radius = inner
  cairo_set_line_width (cr,width)
  cairo_set_source_rgba(cr,red,green,blue,alpha)
  cairo_arc (cr,clockx,clocky,radius,0,2*math.pi)
  cairo_stroke(cr)
end
function watch_dial_line(degree,width,alpha)
  length = 25
  hand = clocksize/2 - length
  local color = {0.6,0.6,1,alpha}

  sx = clockx + math.cos(degree*math.pi/180)*hand
  sy = clocky + math.sin(degree*math.pi/180)*hand
  fx = clockx + math.cos(degree*math.pi/180)*(hand+length)
  fy = clocky + math.sin(degree*math.pi/180)*(hand+length)

  cairo_set_line_width (cr,width)
  cairo_set_source_rgba(cr,rgba(color))
  draw_line(sx,sy,fx,fy)
  cairo_stroke(cr)
end
function digital_date()
  font = "Liberation Serif"
  font_size = inner/4
  offset = 1.8
  local color = color1

  text1 = month_name .. " " .. year
  text2 = weekdayn .. " " .. day

  text_extents(text1,font,font_size)
  x = clockx - (extents.width/2 + extents.x_bearing)
  y = clocky - font_size*offset - (extents.height/2 + extents.y_bearing)
  displaytext(x,y,text1,font,font_size,color)
  text_extents(text2,font,font_size)
  x = clockx - (extents.width/2 + extents.x_bearing)
  y = clocky + font_size*offset - (extents.height/2 + extents.y_bearing)
  displaytext(x,y,text2,font,font_size,color)
end

function digital_time()
  font = "Liberation Serif"
  font_size = inner/2
  hours   = hours
  minutes = minutes
  seconds = seconds

  text = hours .. ":" .. minutes .. ":" .. seconds

--[[
  if hours > 13 then
    text = hours-13 .. ":" .. minutes .. " PM"
  else
    text = hours .. ":" .. minutes .. " AM"
  end
]]

  text_extents(text,font,font_size)
  x = clockx - (extents.width/2 + extents.x_bearing)
  y = clocky - (extents.height/2 + extents.y_bearing)
  displaytext(x,y,font,font_size,color)
end

function dig_date02()
  store_image(curdir.."/image/Wing-right.svg","rightwing")
  store_image(curdir.."/image/Wing-left.svg","leftwing")
  month_number = tonumber(month:match("0*(%d+)"))
  font_size = 18
  color = color2

  x = clockx
  y = clocky + 120
  y1 = y + 12
  y2 = y + 36
  --wings(x,y1)
  date02_day(x,y)
  date02_weekday(x,y1)
  date02_month(x,y2)
end
function date02_day(x,y)
  local font = "Roboto"
  local day_number = tonumber(day)
  bgcolor = purple_dark
  indent = 35
  font_size1 = 20
  font_size2 = 24
  date02_day_left_edge = x - indent*3
  date02_day_right_edge = x + indent*3


  text = tostring(correct_date((day_number-3)))
  font_size = font_size1
  text_extents(text,font,font_size)
  x1 = x - indent*3 - (extents.width/2 + extents.x_bearing)
  color = color5
  displaytext(x1,y,text,font,font_size,color)

  text = tostring(correct_date((day_number-2)))
  font_size = font_size1
  text_extents(text,font,font_size)
  x2 = x - indent*2 - (extents.width/2 + extents.x_bearing)
  color = color5
  displaytext(x2,y,text,font,font_size,color)

  text = tostring(correct_date((day_number-1)))
  font_size = font_size1
  text_extents(text,font,font_size)
  x3 = x - indent*1 - (extents.width/2 + extents.x_bearing)
  color = color5
  displaytext(x3,y,text,font,font_size,color)

  text = tostring(correct_date(day_number))
  font_size = font_size2
  text_extents(text,font,font_size)
  x4 = x - indent*0 - (extents.width/2 + extents.x_bearing)
  color = color1
  displaytext(x4,y,text,font,font_size,color)

  text = tostring(correct_date((day_number+1)))
  font_size = font_size1
  text_extents(text,font,font_size)
  x5 = x + indent*1 - (extents.width/2 + extents.x_bearing)
  color = color5
  displaytext(x5,y,text,font,font_size,color)

  text = tostring(correct_date((day_number+2)))
  font_size = font_size1
  text_extents(text,font,font_size)
  x6 = x + indent*2 - (extents.width/2 + extents.x_bearing)
  color = color5
  displaytext(x6,y,text,font,font_size,color)

  text = tostring(correct_date((day_number+3)))
  font_size = font_size1
  text_extents(text,font,font_size)
  x7 = x + indent*3 - (extents.width/2 + extents.x_bearing)
  color = color5
  displaytext(x7,y,text,font,font_size,color)
end
function date02_weekday(x,y)
  local indent = 35
  local font = "Roboto"
  font_size1 = 8
  font_size2 = 10
  color = 5
  local weekday_number = tonumber(os.date("%w"))
  if weekday_number == 0 then
    weekday_number = 7
  end
  weekday_t = {"Fr","Sa","S","Mo","Tu","We","Th","Fr","Sa","S","Mo","Tu","We"}
  local function weekday(weekday_num)
    return weekday_t[weekday_num+3]
  end
  text = tostring(weekday(weekday_number-3))
  font_size = font_size1
  text_extents(text,font,font_size)
  x1 = x - indent*3 - (extents.width/2 + extents.x_bearing)
  color = color5
  displaytext(x1,y,text,font,font_size,color)

  text = tostring(weekday(weekday_number-2))
  font_size = font_size1
  text_extents(text,font,font_size)
  x2 = x - indent*2 - (extents.width/2 + extents.x_bearing)
  color = color5
  displaytext(x2,y,text,font,font_size,color)

  text = tostring(weekday(weekday_number-1))
  font_size = font_size1
  text_extents(text,font,font_size)
  x3 = x - indent*1 - (extents.width/2 + extents.x_bearing)
  color = color5
  displaytext(x3,y,text,font,font_size,color)

  text = tostring(weekday(weekday_number))
  font_size = font_size2
  text_extents(text,font,font_size)
  x4 = x - indent*0 - (extents.width/2 + extents.x_bearing)
  color = color1
  displaytext(x4,y,text,font,font_size,color)

  text = tostring(weekday(weekday_number+1))
  font_size = font_size1
  text_extents(text,font,font_size)
  x5 = x + indent*1 - (extents.width/2 + extents.x_bearing)
  color = color5
  displaytext(x5,y,text,font,font_size,color)

  text = tostring(weekday(weekday_number+2))
  font_size = font_size1
  text_extents(text,font,font_size)
  x6 = x + indent*2 - (extents.width/2 + extents.x_bearing)
  color = color5
  displaytext(x6,y,text,font,font_size,color)

  text = tostring(weekday(weekday_number+3))
  font_size = font_size1
  text_extents(text,font,font_size)
  x7 = x + indent*3 - (extents.width/2 + extents.x_bearing)
  color = color5
  displaytext(x7,y,text,font,font_size,color)
end
function date02_month(x,y)
  local font = "Roboto"
  font_size1 = 16
  font_size2 = 20
  indent = 50

  month_name_t = {
    "DEC","JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC","JAN"}
  text = month_name_t[month_number]
  font_size = font_size1
  text_extents(text,font,font_size)
  x1 = x - indent*1 - (extents.width/2 + extents.x_bearing)
  color = color5
  displaytext(x1,y,text,font,font_size,color)

  text = month_name_t[month_number+1]
  font_size = font_size2
  text_extents(text,font,font_size)
  x2 = x - indent*0 - (extents.width/2 + extents.x_bearing)
  color = color1
  displaytext(x2,y,text,font,font_size,color)

  text = month_name_t[month_number+2]
  font_size = font_size1
  text_extents(text,font,font_size)
  x3 = x + indent*1 - (extents.width/2 + extents.x_bearing)
  color = color5
  displaytext(x3,y,text,font,font_size,color)
end
function wings(x,y)
  local xoffset = -130
  local yoffset = -50
  local seconds = tonumber(seconds)
  if seconds ~= 30 then
    color = color8
  else
    color = color5
  end
  iconsize = 100
  origsize = 324
  iconx = x + xoffset + iconsize*1.35
  icony = y + yoffset
  draw_image(iconx,icony,"rightwing",iconsize,origsize,color)
  iconx = x + xoffset
  icony = y + yoffset
  draw_image(iconx,icony,"leftwing",iconsize,origsize,color)
end
function correct_date(date)
  local days = get_days_in_month(month_number,year)
  if date > days then
    date = date - days
  end
  return date
end
