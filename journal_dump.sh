#!/bin/bash
journalctl -n 14 | sed 1d | awk '{$1=$2=$4=""; print $0}' | sed 's/  //' | sed 's/  / /' | cut -c1-80 > ~/.config/conky/.tmp/journal
