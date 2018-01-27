config = {
  network = {
    enabled = true, -- if false, it still won't turn off the graph, you will have to disable it in conky.conf
    speedtest = {
      enabled = true,
      interval = 600 -- in seconds
    }
  },
  info = {
    enabled = true,
    package_update = {
      enabled = true
    },
    gmail = { -- ID to get unread email
      enabled = true,
      address = "xxxxxx@gmail.com",
      passphrase = "xxxxxx"
    },
    class_update = {
      enabled = false,
      file = home.."/timetable.txt",  -- home = ~, curdir = ~/.config/conky, concatenate paths with ..
      advance = 10, -- minutes. How early it will inform you of the next class. set to 0 to disable
      starttime = nil, -- if you wish to start the countdown before "first class - advance", specify a time in minutes (6:10 -> 370 (6*60+10*1)), set to nil to disable
      wintertime = 0, -- minutes. To move all the scheduled time in your timetable by a certain amount of time.
      vacation = { -- {year,month,day}
        enabled = true,
        summer = {
          enabled = true,
          start = {2017,7,13},
          finish = {2017,9,6}
        },
        winter = {
          enabled = true,
          start = {2017,12,15},
          finish = {2018,1,9}
        },
        spring = {
          enabled = true,
          start = {2018,3,10},
          finish = {2018,4,5}
        }
      }
    }
  },
  weather = {
    enabled = true,
    area = "JAXX0085" -- default is Tokyo, see https://weather.codes/
  },
  calendar = {
    enabled = true,
    layout = { -- IMPORTANT column * row must be dates. OR IT WILL NOT WORK PROPERLY
      dates = 14,
      column = 2,
      row = 7
    }
  },
  word_of_the_day = {
    enabled = true
  },
  log = {
    enabled = true
  },
  storage = {
    enabled = true
  },
  clock = {
    enabled = true,
    logo = 1 -- 1:Arch 2:Ubuntu
  }
}
