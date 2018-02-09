function word_of_the_day(x,y)
  amount = 3

  if ic == 1 then
    if io.open(curdir.."/.tmp/word_of_the_day") == nil then
      get_word_of_the_day(amount)
    end
    local file = io.open(curdir.."/.tmp/word_of_the_day_count")
    for line in file:lines() do
      date = line
    end
    file:close()
    if date ~= os.date("%x") then
      get_word_of_the_day(amount)
      wotd_changed = 1
    end
  end
  if conky_start == 1 or wotd_changed == 1 then
    if io.open(curdir.."/.tmp/word_of_the_day")==nil then return end
    file = io.open(curdir.."/.tmp/word_of_the_day")
    word_t = {}
    for line in file:lines() do
      table.insert(word_t,line)
    end
    file:close()
    for i in range(1,amount,1) do
      file = io.open(curdir.."/.tmp/word_of_the_day_definition_"..tostring(i))
      _G["definition_"..i.."_t"] = {}
      for line in file:lines() do
        table.insert(_G["definition_"..i.."_t"],line)
      end
    end
    file:close()
    wotd_changed = 0
  end

  do -- Word
    text = word_t[1]
    font_size = 25
    text_extents(text,font,font_size)
    color = color5
    local x = x + 105 - (extents.width/2 + extents.x_bearing)
    local y = y + 15 - (extents.height/2 + extents.y_bearing)
    displaytext(x,y,text,font,font_size,color)
  end
  do -- Definition
    spacing = 1.1
    local x = x - 10
    local y = y + 50
    for i in range(1,amount,1) do
      for _,line in ipairs(_G["definition_"..i.."_t"])do
        if _ == 1 then
          line = "1. "..line
        end
        local text = line
        local font = "Inconsolata"
        local font_size = 15
        local color = color5
        if y > 1020 then
          break
        end
        displaytext(x,y,text,font,font_size,color)
        y = y + font_size*spacing
      end
    end
  end
end
function get_word_of_the_day(amount)
  --os.execute("curl -s http://www.dictionary.com/wordoftheday/ > /.tmp/word_of_the_day")
  os.execute("curl -s http://www.dictionary.com/wordoftheday/ | sed -n 's:.*<strong>\\(.*\\)<\\/strong>.*:\\1:p' | uniq > "..curdir.."/.tmp/word_of_the_day")
  for number in range(1,amount,1) do
    os.execute("curl -s http://www.dictionary.com/wordoftheday/ | sed -n 's/.*<li class=\""..number2literal_ordinal_number(number).."\"><span>\\(.*\\)<\\/span>.*/\\1/p;' | sed 's/<em>/\\n/g; s/<\\/em>//g' | fold -w 29 -s > "..curdir.."/.tmp/word_of_the_day_definition_"..tostring(number))
  end
  local file = io.open(curdir.."/.tmp/word_of_the_day_count","w")
  file:write(os.date("%x"))
  file:close()
end
