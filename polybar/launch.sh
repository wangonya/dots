#!/bin/bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config.ini
# polybar example 2>&1 | tee -a /tmp/polybar.log & disown

CONFIG_DIR=$HOME/dots/polybar/config.ini

polybar --reload main -c $CONFIG_DIR &
