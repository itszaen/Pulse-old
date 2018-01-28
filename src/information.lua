dofile(curdir.."/src/drawimage.lua")
dofile(curdir.."/src/timetable.lua")

function information(x,y)
  -- store images
  if conky_start == 1 then
    path = curdir .. "/image/Update.svg"
    name = "update"
    store_image(path,name)
    path = curdir .. "/image/Up_to_date.svg"
    name = "uptodate"
    store_image(path,name)
    path = curdir .. "/image/Class.svg"
    name = "class"
    store_image(path,name)
    path = curdir .. "/image/Email.svg"
    name = "email"
    store_image(path,name)
    path = curdir .. "/image/Email_empty.svg"
    name = "emailempty"
    store_image(path,name)
  end

  if config.info.package_update.enabled then
    indent = 15
    pux = x + indent
    puy = y
    package_update(pux,puy)
  end

  if config.info.class_update.enabled then
    indent = 15
    spacing = 60
    cux = x + indent
    cuy = y + spacing
    class_update(cux,cuy)
  end

  if config.info.gmail.enabled then
    indent = 15
    spacing = 120
    eux = x + indent
    euy = y + spacing
    email_update(eux,euy)
  end

  six = x + 100
  siy = y
  software_info(x,y)
end
function package_update(x,y)
  interval = 30
  timer = (updates % interval)

  if timer == 0 or conky_start == 1 then
    update_number = getUpdate()
  end

  if update_number == "0" then
    iconsize = 30
    iconorig = 225
    color = color5
    iconx = x - 17
    icony = y - 6
    iconname = "uptodate"
    draw_image(iconx,icony,iconname,iconsize,iconorig,color)
    font_size = 16
    indent = 30
    spacing = 18
    color = color2
    x = x + indent
    y = y + spacing
    text = "Your system is up to date!"
    displaytext(x,y,text,font,font_size,color)
  elseif update_number == nil then
    iconsize = 30
    iconorig = 225
    color = color5
    iconx = x - 17
    icony = y - 6
    iconname = "update"
    draw_image(iconx,icony,iconname,iconsize,iconorig,color)
    font_size = 16
    indent = 30
    spacing = 18
    color = color2
    x = x + indent
    y = y + spacing
    text = "Error reading information."
    displaytext(x,y,text,font,font_size,color)
  else
    iconsize = 30
    iconorig = 225
    color = color5
    iconx = x - 17
    icony = y - 6
    iconname = "update"
    draw_image(iconx,icony,iconname,iconsize,iconorig,color)
    font_size = 16
    indent = 30
    spacing = 18
    color = color2
    x = x + indent
    y = y + spacing
    text = update_number .. " packages can be updated."
    displaytext(x,y,text,font,font_size,color)
  end
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
  return update_number
end
function email_update(x,y)
  interval = 300
  timer = (updates % interval)

  if ic == 1 and (conky_start == 1 or timer == 0) then
    gmail_info = getGmail()
  end
  if ic ~= 1 then
    iconsize = 30
    iconorig = 225
    iconcolor = color5
    iconx = x - 16
    icony = y - 15
    iconname = "email"
    draw_image(iconx,icony,iconname,iconsize,iconorig,iconcolor)
    font_size = 16
    indent = 28
    spacing = 9
    color = color2
    x = x + indent
    y = y + spacing
    text = "Internet disconnected."
    displaytext(x,y,text,font,font_size,color)
  elseif gmail_info == "0" then
    iconsize = 30
    iconorig = 225
    iconcolor = color5
    iconx = x - 16
    icony = y - 15
    iconname = "emailempty"
    draw_image(iconx,icony,iconname,iconsize,iconorig,iconcolor)
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
    iconname = "email"
    draw_image(iconx,icony,iconname,iconsize,iconorig,iconcolor)

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
    iconname = "email"
    draw_image(iconx,icony,iconname,iconsize,iconorig,iconcolor)

    font_size = 16
    indent = 30
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
  local address = config.info.gmail.address
  local passphrase = config.info.gmail.passphrase
  return address,passphrase
end
function class_update(x,y)
  local interval = 1

  local timer = (updates % interval)

  do
    local iconsize = 30
    local iconorig = 512
    local iconcolor = color5
    local iconx = x - 17
    local icony = y - 10
    local iconname = "class"
    draw_image(iconx,icony,iconname,iconsize,iconorig,iconcolor)
  end

  do
    font_size = 16
    color = color2
    indent = 30
    spacing = 13
    x = x + indent
    y = y + spacing

    local advance = config.info.class_update.advance
    local wintertime = config.info.class_update.advance
    local starttime = config.info.class_update.starttime

    if timer == 0 then
      text,time = classinfo(advance,wintertime,starttime)
    end
    if time == "now" then
      text1 = "The class is "
      displaytext(x,y,text1,font,font_size,color)
      text_extents(text1,font,font_size)
      text2 = text
      local font = "Source Han Sans JP"
      font_size = 13
      indent = 6 + extents.width + extents.x_bearing
      x = x + indent
      displaytext(x,y,text2,font,font_size,color)
    elseif time == nil then
      displaytext(x,y,text,font,font_size,color)
    else
      text1 = time .. " until"
      displaytext(x,y,text1,font,font_size,color)
      text_extents(text1,font,font_size)
      text2 = text
      local font = "Source Han Sans JP"
      font_size = 13
      indent = 6 + extents.width + extents.x_bearing
      x = x + indent
      displaytext(x,y,text2,font,font_size,color)
    end
  end
end
function software_info(x,y)

end
