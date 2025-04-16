#!/bin/bash

STATUS=$(xrandr --query | grep "DP-1 connected" | grep -o " [0-9][0-9]*")

if [ -n "$STATUS" ]; then
  xrandr --output DP-1 --off
else
  xrandr --output DP-1 --auto
fi
