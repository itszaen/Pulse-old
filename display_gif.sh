#!/bin/sh

# In courtesy of Ubuntu Forum user, memorygap from this thread: https://ubuntuforums.org/showthread.php?t=926519
# I made a slight change so that it would have the correct number in SCRH and SCRW when using dual screen setup.
# (It is not really well written, PRs are appreciated!)

# Uses xwinwrap to display given animated .gif in the center of the screen

if [ $# -ne 1 ]; then
    echo 1>&2 Usage: $0 image.gif
    exit 1
fi

#get screen resolution
SCRW=`xrandr |awk '{for(i=1;i<=NF;i++)if($i~/primary/)print $(i+1)}'|sed 's/x/ /'|sed 's/+/ /'|awk '{$3=""; print$1}'`
SCRH=`xrandr |awk '{for(i=1;i<=NF;i++)if($i~/primary/)print $(i+1)}'|sed 's/x/ /'|sed 's/+/ /'|awk '{$3=""; print$2}'`

#get gif resolution
IMGHW=`gifsicle --info $1 | awk '/logical/ { print $3 }'`
IMGH=${IMGHW%x*}
IMGW=${IMGHW#*x}

#calculate position
POSW=$((($SCRW/2)-($IMGH/2)))
POSH=$((($SCRH/2)-($IMGW/2)))

xwinwrap -g ${IMGHW}+${POSW}+${POSH} -ov -ni -s -nf -b -sh circle -- gifview -w WID $1 -a

exit 0
