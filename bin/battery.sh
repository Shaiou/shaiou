#!/bin/bash

BAT=$(acpi -b | grep -v "rate information unavailable" |grep  "Battery" | grep -E -o '1*[0-9][0-9]?%')

# Full and short texts
echo "Battery: $BAT"
echo "BAT: $BAT"

# Set urgent flag below 5% or use orange below 20%
[ ${BAT%?} -le 15 ] && notify-send -i ~/Icons/low-battery.png "${BAT%?} % remaining"

exit 0
