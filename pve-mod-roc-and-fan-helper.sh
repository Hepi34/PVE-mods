#!/bin/bash
temp=$(storcli /c0 show temperature | grep "ROC temperature" | awk '{print $NF}')
fanspeed=$(journalctl -b -u pyfan.service -n 35 | grep "New fan speed" | awk '{print $8}' |  awk -F'[^0-9]+' '{print $2}')
maxrpm=11500
rpm=$(( fanspeed * maxrpm / 100 ))

# clean files before writing
> /var/log/pvemodhelper/roctemp.log
> /var/log/pvemodhelper/fanspeed.log
> /var/log/pvemodhelper/fanrpm.log

echo $temp >> /var/log/pvemodhelper/roctemp.log 
echo $fanspeed >> /var/log/pvemodhelper/fanspeed.log
echo $rpm >> /var/log/pvemodhelper/fanrpm.log

printf "ROC Temperature: %s °C\n" "$temp"
printf "Fan Speed: %s %%\n" "$fanspeed"
printf "Fan RPM: %s RPM\n" "$rpm"

sleep 10    