#!/bin/bash

killall -q polybar

CONFIG_DIR=$HOME/dots/polybar/config.ini

# if [[ $(xrandr -q | grep "${EXTERNAL_MONITOR} connected") ]]; then
#     MONITOR=HDMI-1
# else
#     MONITOR=eDP-1
# fi
# MONITOR=$MONITOR polybar main -c $CONFIG_DIR &

polybar main -c $CONFIG_DIR &
