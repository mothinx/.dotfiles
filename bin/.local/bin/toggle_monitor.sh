#!/bin/bash

STATUS=$(xrandr --query | grep "DP-2 connected" | grep -o " [0-9][0-9]*")

if [ -n "$STATUS" ]; then
  xrandr --output DP-2 --off
else
  xrandr --output DP-2 --auto --right-of DP-1
fi
