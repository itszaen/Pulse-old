#!/bin/bash
speedtest-cli --simple > /home/zaen/.config/conky/.tmp/.speeds
cat /home/zaen/.config/conky/.tmp/.speeds | sed 's/Ping/PNG/' | sed 's/Download/DWN/' | sed 's/Upload/UPL/'  > /home/zaen/.config/conky/.tmp/speeds