require 'drawimage'
require 'timetable'

function information(x,y)
  indent = 15
  pux = x + indent
  puy = y
  package_update(pux,puy)

  indent = 15
  spacing = 60
  cux = x + indent
  cuy = y + spacing
  class_update(cux,cuy)

  indent = 15
  spacing = 120
  eux = x + indent
  euy = y + spacing
  email_update(eux,euy)

  six = x + 100
  siy = y
  software_info(x,y)
end
function package_update(x,y)
  interval = 30
  iconsize = 30
  iconorig = 225
  color = color5
  iconx = x - 17
  icony = y - 6
  iconpath = curdir .. "/image/Update.svg"
  iconname = "update"
  draw_image(iconx,icony,iconpath,iconname,iconsize,iconorig,color)

  timer = (updates % interval)

  if timer == 0 or conky_start == 1 then
    update_info = getUpdate()
  end
  text = update_info
  font = "Inconsolata"
  font_size = 16
  indent = 28
  spacing = 18
  color = color2
  x = x + indent
  y = y + spacing

  displaytext(x,y,text,font,font_size,color)
end
function getUpdate()
  if osname == "Arch" then
    update_info = assert(io.popen("checkupdates | wc -l"))
    for line in update_info:lines() do
      for number in line:gmatch("%d+") do
        update_number = number
        break
      end
      break
    end
  elseif osname == "Ubuntu" then
    update_info = assert(io.popen("cat /etc/issue"))
    for line in update_info:lines() do
      for number in line:gmatch(",+") do
        update_number = number
        break
      end
      break
    end
  end
  if update_number == 0 then
    text = "Your system is up to date!"
  elseif update_number == nil then
    text = "Error reading information."
  else
    text = update_number .. " packages need updating."
  end
  return text
end
function email_update(x,y)
  interval = 300
  timer = (updates % interval)

  if conky_start == 1 or timer == 0 then
    gmail_info = getGmail()
  end
  if gmail_info == 0 then
    iconsize = 30
    iconorig = 225
    iconcolor = color5
    iconx = x - 16
    icony = y - 15
    iconpath = curdir .. "/image/Email_empty.svg"
    iconname = "email"
    draw_image(iconx,icony,iconpath,iconname,iconsize,iconorig,iconcolor)
    font = "Inconsolata"
    font_size = 16
    indent = 28
    spacing = 9
    color = color2
    x = x + indent
    y = y + spacing
    text = "You have no unread emails."
    displaytext(x,y,text,font,font_size,color)
  elseif gmail_info == nil or gmail_info == "error" then
    iconsize = 30
    iconorig = 225
    iconcolor = color5
    iconx = x - 16
    icony = y - 15
    iconpath = curdir .. "/image/Email.svg"
    iconname = "email"
    draw_image(iconx,icony,iconpath,iconname,iconsize,iconorig,iconcolor)

    font = "Inconsolata"
    font_size = 16
    indent = 28
    spacing = 9
    color = color2
    x = x + indent
    y = y + spacing
    text = "Error reading information."

    displaytext(x,y,text,font,font_size,color)
  else
    iconsize = 30
    iconorig = 225
    iconcolor = color5
    iconx = x - 16
    icony = y - 15
    iconpath = curdir .. "/image/Email.svg"
    iconname = "email"
    draw_image(iconx,icony,iconpath,iconname,iconsize,iconorig,iconcolor)

    font = "Inconsolata"
    font_size = 16
    indent = 28
    spacing = 9
    color = color2
    x = x + indent
    y = y + spacing
    text = "You have "..gmail_info.." unread emails."

    displaytext(x,y,text,font,font_size,color)
  end

end
function getGmail()
  if conky_start == 1 or email_change ==1 then
    gmail_address,gmail_password = getGmailCredit()
  end
  result = assert(io.popen("curl -s -u "..gmail_address..":"..gmail_password..[[ https://mail.google.com/mail/feed/atom | sed -n 's:.*<fullcount>\(.*\)</fullcount>.*:\1:p']]))
  for line in result:lines() do
    for number in line:gmatch("%d+") do
      unread_mail = number
      break
    end
    break
  end
  result:close()
  return unread_mail
end
function getGmailCredit()
  address_f = io.open(curdir.."/.gmail")
  for line in address_f:lines() do
    address = line
    break
  end
  password_f = io.popen("python -c \"import keyring; print(keyring.get_password('gmail','"..address.."'))\"")
  for line in password_f:lines() do
    password = line
    break
  end
  return address,password
end
function class_update(x,y)
  interval = 60
  iconsize = 30
  iconorig = 512
  iconcolor = color5
  iconx = x - 17
  icony = y - 10
  iconpath = curdir .. "/image/Class.svg"
  iconname = "class"
  draw_image(iconx,icony,iconpath,iconname,iconsize,iconorig,iconcolor)

  timer = (updates % interval)

  font = "Inconsolata"
  font_size = 16
  color = color2
  indent = 28
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
