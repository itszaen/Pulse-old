function information(x,y)
  sy = y
  package_update(x,y)

  x = x + 30
  y = y + 20
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


  timer = (updates % interval)

  if timer == 0 or conky_start == 1 then
    update_number = tonumber(conky_parse("${exec checkupdates | wc -l}"))
  end
  text1 = "System update"
  if update_number == 0 then
    text2 = "Your system is up to date!"
  elseif update_number == nil then
    text2 = "Error reading information."
  else
    text2 = update_number .. " packages need updating."
  end

  heading2(x,y,text1)

  font = "Inconsolata"
  font_size = 16
  spacing = 1.2
  indent = 20
  color = color1
  x = x + indent
  y = y + font_size*spacing
  displaytext(x,y,text2,font,font_size,color)
end
function email_update(x,y)

end
function class_update(x,y)

end
function software_info(x,y)

end
