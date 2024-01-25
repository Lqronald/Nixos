#!/bin/bash

# Check if Hyprland is still running
#if pgrep -x Hyprland >/dev/null; then
  # If Hyprland is alive, kill it gracefully
  hyprctl dispatch exit 0
#  sleep 2

  #If Hyprland didn't exit gracefully, kill it forcefully
#  if pgrep -x Hyprland >/dev/null; then
#    pkill -9 Hyprland
#  fi
#fi
