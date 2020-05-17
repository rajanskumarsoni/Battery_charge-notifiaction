#
#!/bin/bash

SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=root
charge=$(/bin/cat /sys/class/power_supply/BAT0/capacity)
batterystatus=$(/bin/cat /sys/class/power_supply/BAT0/status)

/bin/sleep 5
if [[ $charge -le 40 && $batterystatus -eq  Discharging ]];
then
	# touch /home/unigalso/io.txt
	eval "export $(egrep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u $LOGNAME gnome-session)/environ)"; /usr/bin/notify-send 'Battery charging less than threshold.Please charge it!' -u normal -t 10000 -i face-worried
elif [[ $charge -ge 80 && $batterystatus -eq  Charging ]];
then
	# touch /home/unigalso/io.txt
	eval "export $(egrep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u $LOGNAME gnome-session)/environ)"; /usr/bin/notify-send ' Battery has sufficient charge. Please remove the chager!' -u normal -t 10000 -i face-worried
elif [[ $batterystatus -eq Unknown ]];
then
	eval "export $(egrep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u $LOGNAME gnome-session)/environ)"; /usr/bin/notify-send 'Fully charged ' -u normal -t 10000 -i face-worried
else
	echo $batterystatus
	echo $charge
	eval "export $(egrep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u $LOGNAME gnome-session)/environ)"; /usr/bin/notify-send "Something wrong, $batterystatus, $charge" -u normal -t 10000 -i face-worried

fi



