require 'icon'
require 'timetable'

function information(x,y)
  indent = 15
  spacing = 120
  sy = y
  x = x + indent

  package_update(x,y)

  y = y + 120
  email_update(x,y)

  x = x
  y = y + 20
  class_update(x,y)

  x = x + 100
  y = sy
  software_info(x,y)
end
function package_update(x,y)
  interval = 30
  iconsize = 30
  color = color5
  icony = y
  icon_update(x,icony,iconsize,color,1)

  timer = (updates % interval)

  if timer == 0 or conky_start == 1 then
    update_number = tonumber(conky_parse("${exec checkupdates | wc -l}"))
  end

  if update_number == 0 then
    text = "Your system is up to date!"
  elseif update_number == nil then
    text = "Error reading information."
  else
    text = update_number .. " packages need updating."
  end

  font = "Inconsolata"
  font_size = 16
  indent = 25
  spacing = 18
  color = color1
  x = x + indent
  y = y + spacing
  displaytext(x,y,text,font,font_size,color)
end
function email_update(x,y)

end
function class_update(x,y)
  interval = 60
  iconsize = 30
  iconcolor = color5
  iconx = x - 12
  icony = y - 3
  teaching_icon(iconx,icony,iconsize,color)

  timer = (updates % interval)

  font = "Inconsolata"
  font_size = 16
  color = color2
  indent = 25
  spacing = 13
  x = x + indent
  y = y + spacing
  text1 = "Next class is "
  displaytext(x,y,text1,font,font_size,color)
  text_extents(text1,font,font_size)
  text2 = classinfo()
  font = "Source Han Sans JP"
  font_size = 13
  indent = 6 + extents.width + extents.x_bearing
  x = x + indent
  displaytext(x,y,text2,font,font_size,color)
end
function software_info(x,y)

end
