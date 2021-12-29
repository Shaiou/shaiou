#!/bin/bash

BAT=$(acpi -b | grep "Battery 0" | egrep -E -o '[0-9][0-9]?%')

# Full and short texts
echo "Battery: $BAT"
echo "BAT: $BAT"

# Set urgent flag below 5% or use orange below 20%
[ ${BAT%?} -le 5 ] && exit 33
[ ${BAT%?} -le 15 ] && notify-send -i ~/Icons/low-battery.png "${BAT%?} % remaining"
[ ${BAT%?} -le 20 ] && echo "#FF8000"

exit 0
