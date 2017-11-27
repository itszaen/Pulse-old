#!/bin/bash
journalctl -n 14 | sed 1d | awk '{$1=$2=$4=""; print $0}' | sed 's/  //' | sed 's/  / /' |sed -e 's/kernel/${color af2445}kernel${color}/' -e 's/root/${color 23ada0}root${color}/'| cut -c1-90 > ~/.config/conky/tmp/journal.txt
