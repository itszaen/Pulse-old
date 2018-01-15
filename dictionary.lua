function word_of_the_day(x,y)
  if conky_start == 1 then
    path = curdir.."/image/dictionarydotcom.svg"
    name = "dictionarydotcom"
    store_image(path,name)
  end
  if io.open(curdir.."/.tmp/word_of_the_day") == nil then
    get_word_of_the_day()
  end
  if conky_start == 1 then
    file = io.open(curdir.."/.tmp/word_of_the_day")
    wotd_t = {}
    for line in file:lines() do
      table.insert(wotd_t,line)
    end
    file:close()
  end
  word = wotd_t[1]
  number = "first"
  print("curl -s http://www.dictionary.com/wordoftheday/ | sed -n 's:.*<li class="..number.."><span>\\(.*\\)<\\/span>.*:\\1:p' >> "..curdir.."/.tmp/word_of_the_day")
  definition_number = 0
  for i in range(2,5,1) do
    if wotd[i] == nil then
      break
    else
      _G["definition_"..i] = wotd[i]
      definition_number = definition_number + 1
    end
  end

  do
    text = word
    font_size = 25
    text_extents(text,font,font_size)
    color = color5
    local x = x + 105 - (extents.width/2 + extents.x_bearing)
    local y = y + 15 - (extents.height/2 + extents.y_bearing)
    displaytext(x,y,text,font,font_size,color)

  end
end
function get_word_of_the_day()
  os.execute("curl -s http://www.dictionary.com/wordoftheday/ | sed -n 's:.*<strong>\\(.*\\)<\\/strong>.*:\\1:p' | uniq > "..curdir.."/.tmp/word_of_the_day")
  for number in range(1,3,1) do
    os.execute("curl -s http://www.dictionary.com/wordoftheday/ | sed -n 's:.*<li class="..number.."><span>\\(.*\\)<\\/span>.*:\\1:p' >> "..curdir.."/.tmp/word_of_the_day")
  end
end
