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
      file = "timetable.txt"
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
