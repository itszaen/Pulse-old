require 'logo'

function clock()
  clocksize = center
  inner = 50
  digital_t = 0
  logosize = 60
  logox = 0
  logoy = -125
  if digital_t == 1 then
    digital_date()
    digital_time()
    innerline()
  else end
  analog_time()
  watch_dial()
  archlogo(logox,logoy,logosize)
end


function analog_time()
  hour_degree = hours12*360/12 + minutes*360/720 + seconds*360/43200 -90
  minute_degree = minutes*360/60 + seconds*360/3600 -90
  second_degree = seconds*360/60 -90
  if digital_t == 1 then
    hour_length = 0.7
    minute_length = 0.9
    second_length = 1.0
  else
    hour_length = 0.5
    minute_length = 0.8
    second_length = 1.0
  end
  watch_hand(hour_degree,5,hour_length)
  watch_hand(minute_degree,3,minute_length)
  watch_hand(second_degree,1,second_length)

end
function watch_hand(degree,width,ratio)
  size = clocksize
  local color = color1
  if digital_t ==1 then
    sx = centerx + math.cos(degree*math.pi/180)*inner
    sy = centery + math.sin(degree*math.pi/180)*inner
  fx = sx + ratio*(math.cos(degree*math.pi/180)*(size/2-25-inner))
  fy = sy + ratio*(math.sin(degree*math.pi/180)*(size/2-25-inner))
  else
    sx = centerx
    sy = centery
    fx = sx + ratio*(math.cos(degree*math.pi/180)*(size/2-25))
    fy = sy + ratio*(math.sin(degree*math.pi/180)*(size/2-25))
  end
  cairo_set_line_width (cr,width)
  cairo_set_source_rgba (cr,rgba(color))
  draw_line(sx,sy,fx,fy)
  cairo_stroke(cr)

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
  cairo_arc (cr,centerx,centery,radius,0,2*math.pi)
  cairo_stroke(cr)
end
function watch_dial_line(degree,width,alpha)
  length = 25
  hand = clocksize/2 - length
  local color = {0.6,0.6,1,alpha}

  sx = centerx + math.cos(degree*math.pi/180)*hand
  sy = centery + math.sin(degree*math.pi/180)*hand
  fx = centerx + math.cos(degree*math.pi/180)*(hand+length)
  fy = centery + math.sin(degree*math.pi/180)*(hand+length)

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

  text1 = monthn .. " " .. year
  text2 = weekdayn .. " " .. day

  text_extents(text1,font,font_size)
  x = centerx - (extents.width/2 + extents.x_bearing)
  y = centery - font_size*offset - (extents.height/2 + extents.y_bearing)
  displaytext(x,y,text1,font,font_size,color)
  text_extents(text2,font,font_size)
  x = centerx - (extents.width/2 + extents.x_bearing)
  y = centery + font_size*offset - (extents.height/2 + extents.y_bearing)
  displaytext(x,y,text2,font,font_size,color)
end

function digital_time()
  font = "Liberation Serif"
  font_size = inner/2
  local color = color1
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
  x = centerx - (extents.width/2 + extents.x_bearing)
  y = centery - (extents.height/2 + extents.y_bearing)
  displaytext(x,y,font,font_size,color)
end
