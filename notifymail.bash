#!/bin/bash

# http://askubuntu.com/questions/298608/notify-send-doesnt-work-from-crontab
eval "export $(egrep -z DBUS_SESSION_BUS_ADDRESS /proc/$(ps -u $LOGNAME -ef|grep bin/gnome-shell|grep -v grep|awk '{print $2}')/environ)";
export DISPLAY=:0

cwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $cwd

num=$(./checkmail $1 2>&1)


if [ ! -f nummail ]; then
  previous=0
  echo $num > nummail
else
  previous=$(cat nummail)
  echo $num > nummail
fi

real=$((num-previous))

if [[ $real > 0 ]]; then
  notify-send --hint int:transient:1 -t 1000 -a 'Mail Notifier' 'Mail' "$real new messages" 2>/dev/null
fi
