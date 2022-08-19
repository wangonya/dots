#!/bin/bash

killall -q polybar

CONFIG_DIR=$HOME/dots/polybar/config.ini

polybar main -c $CONFIG_DIR &
