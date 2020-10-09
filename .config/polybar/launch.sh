#!/usr/bin/env bash

# network
export WLAN=$(ip link | grep wlp | awk -F ": " '{print $2}')
export ETH=$(ip link | grep enp | awk -F ": " '{print $2}')

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar1 and bar2
echo "---" | tee -a /tmp/bottom.log
polybar bottom >>/tmp/bottom.log 2>&1 &

echo "Bars launched..."
