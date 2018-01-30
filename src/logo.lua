dofile(curdir.."/src/drawimage.lua")

function archlogo(x,y,size)
  spacing = size - 15
  archicon(x,y,size,color2)
  archname(x,y+spacing,size)
end
function archicon(x,y,size,color)
  if conky_start == 1 then
    path = curdir .. "/image/Archlinux.svg"
    name = "archicon"
    store_image(path,name,166)
  end
  name = "archicon"
  x = x - size/2
  y = y - size/2
  draw_image(x,y,name,size,color)
end

function archname(x,y,size)
  local font = "Z003"
  font_size = size/2.3
  color = color2
  text = "Arch Linux"
  text_extents(text,font,font_size)
  x = x - (extents.width/2 + extents.x_bearing)
  y = y - (extents.height/2 + extents.y_bearing)
  displaytext(x,y,text,font,font_size,color)
end

function ubuntulogo(x,y,size)
  local iconoffsetx = -8 -- it's a bit off for some reason
  local iconoffsety = -5
  local spacing = size + 30
  ubuntuicon(x+iconoffsetx,y+iconoffsety,size)
  ubuntuname(x,y+spacing,size)
end
function ubuntuicon(x,y,size)
  if conky_start == 1 then
    path = curdir .. "/image/Ubuntu.svg"
    name = "ubuntuicon"
    store_image(path,name,2000)
  end
  name = "ubuntuicon"
  x = x - size/2
  y = y - size/2
  draw_image(x,y,name,size,color)
end
function ubuntuname(x,y,size)
  local font = "Ubuntu"
  font_size = size/2
  color = color4
  text = "Ubuntu"
  text_extents(text,font,font_size)
  x = x  - (extents.width/2 + extents.x_bearing)
  y = y - (extents.width/2 + extents.y_bearing)
  displaytext(x,y,text,font,font_size,color)
end
