#!/bin/bash

set -o pipefail

export DISPLAY=:0.0
export XAUTHORITY=/home/wolfgang/.Xauthority

function connect(){
   logger -t udev "$1 connected"
   xrandr --output $1 --primary --auto --right-of LVDS1
   echo "connect $(date)" >> /home/wolfgang/log
}

function disconnect(){
   logger -t udev "$1 disconnected"
   xrandr --output $1 --off
   xrandr --output LVDS1 --primary
   echo "disconnect $(date)" >> /home/wolfgang/log
}

query=$(xrandr --query)
connected_output=$(echo "${query}" | egrep " connected \(" | awk -F' ' '{print $1}')
echo "co $connected_output"
if [[ ! -z "${connected_output// }" ]]; then
   connect $connected_output
else
   disconnected_output=$(echo "${query}" | egrep " disconnected [^(]" | awk -F' ' '{print $1}')
   echo "do $disconnected_output"
   if [[ ! -z "${disconnected_output// }"  ]]; then
      disconnect $disconnected_output
   fi
fi
nitrogen --restore &
