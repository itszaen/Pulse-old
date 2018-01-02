require 'logo'

function clock()
  clocksize = center
  inner = 50
  digital_t = 0
  logosize = 60
  logox = centerx + 0
  logoy = centery -120
  if digital_t == 1 then
    digital_date()
    digital_time()
    innerline()
  else end
  cairo_set_operator(cr,CAIRO_OPERATOR_SOURCE)
  watch_dial()
  archlogo(logox,logoy,logosize)
  analog_time()
end


function analog_time()
  hour_degree = hours12*360/12 + minutes*360/720 + seconds*360/43200 -90
  minute_degree = minutes*360/60 + seconds*360/3600 -90
  second_degree = seconds*360/60 -90
  hour_length = 0.5
  minute_length = 0.8
  second_length = 1.0
  watch_hand_hour(hour_degree,hour_length)
  watch_hand_minute(minute_degree,minute_length)
  watch_hand_second(second_degree,second_length)
  watch_hand_pin()
end
--[[function watch_hand(degree,width,ratio)
  size = clocksize
  local color = color1
  sx = centerx
  sy = centery
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
  cairo_arc(cr,centerx,centery,outerradius,0,2*math.pi)
  cairo_fill(cr)
  cairo_set_source_rgba(cr,rgba(middlecolor))
  cairo_arc(cr,centerx,centery,outerradius,0,2*math.pi)
  cairo_fill(cr)
  cairo_set_source_rgba(cr,rgba(innercolor))
  cairo_arc(cr,centerx,centery,innerradius,0,2*math.pi)
  cairo_fill(cr)
end
function watch_hand_hour(degree,scale)
 size = clocksize
  length = size/2-25
  sx = centerx
  sy = centery
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
  sx = centerx
  sy = centery
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
function watch_hand_second(degree,scale)
  size = clocksize
  sx = centerx
  sy = centery
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
