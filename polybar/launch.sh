#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar
polybar hdmi2 -c ~/.config/polybar/config.ini &
polybar edp1 -c ~/.config/polybar/config.ini &
