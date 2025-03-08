#!/bin/bash

export DISPLAY=:0
export XAUTHORITY=$(find /run/user/1000 -name Xauthority 2>/dev/null | head -n 1)

if [ -z "$XAUTHORITY" ]; then
    export XAUTHORITY=/home/$USER/.Xauthority
fi
SCREEN_NAME=$(xrandr --query | grep " connected" | awk '{print $1}')

if [ -z "$SCREEN_NAME" ]; then
    echo "Error: No connected screen detected!"
    exit 1
fi
SCREEN_STATUS=$(xrandr --query | grep "$SCREEN_NAME connected" | grep -o " [0-9]\+")

if [ -n "$SCREEN_STATUS" ]; then
    echo "Screen ($SCREEN_NAME) is currently ON. Turning it OFF..."
    xrandr --output "$SCREEN_NAME" --off
else
    echo "Screen ($SCREEN_NAME) is currently OFF. Turning it ON..."
    xrandr --output "$SCREEN_NAME" --auto
fi
