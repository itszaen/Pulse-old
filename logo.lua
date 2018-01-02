require 'drawimage'

function archlogo(x,y,size)
  spacing = size - 15
  archicon(x,y,size,color2)
  archname(x,y+spacing,size)
end
function archicon(x,y,size,color)
  path = curdir .. "/image/Archlinux.svg"
  name = "archicon"
  original = 166
  x = x - size/2
  y = y - size/2
  draw_image(x,y,path,name,size,original,color)
end

function archname(x,y,size)
  font = "Z003"
  font_size = size/2.3
  local color = color2
  text = "Arch Linux"
  text_extents(text,font,font_size)
  x = x - (extents.width/2 + extents.x_bearing)
  y = y - (extents.height/2 + extents.y_bearing)
  displaytext(x,y,text,font,font_size,color)
end

function ubuntulogo(x,y,size)
  spacing = size - 15
  ubuntuicon(x,y,size)
  ubuntuname(x,y+spacing,size)
end
function ubuntuicon(x,y,size)
  path = curdir .. "/image/Ubuntu.svg"
  name = "ubuntuicon"
  original = 2000
  x = x - size/2
  y = y - size/2
  draw_image(x,y,path,name,size,original,color)
end
function ubuntuname(x,y,size)
  font = "Ubuntu"
  font_size = size/2
  local color = color4
  text = "Ubuntu"
  text_extents(text,font,font_size)
  x = x  - (extents.width/2 + extents.x_bearing)
  y = y - (extents.width/2 + extents.y_bearing)
  displaytext(x,y,text,font,font_size,color)
end
