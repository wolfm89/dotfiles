#!/bin/bash

set -o pipefail

export DISPLAY=:0.0
export XAUTHORITY=/home/wolfgang/.Xauthority

function connect(){
   logger -t udev "$1 connected"
   xrandr --output $1 --primary --auto --right-of LVDS1
}

function disconnect(){
   logger -t udev "$1 disconnected"
   xrandr --output $1 --off
   xrandr --output LVDS1 --primary
}

query=$(xrandr --query)
connected_output=$(echo "${query}" | egrep " connected \(" | awk -F' ' '{print $1}')
if [[ ! -z "${connected_output// }" ]]; then
   connect $connected_output
else
   disconnected_output=$(echo "${query}" | egrep " disconnected [^(]" | awk -F' ' '{print $1}')
   if [[ ! -z "${disconnected_output// }"  ]]; then
      disconnect $disconnected_output
   fi
fi
nitrogen --restore &
