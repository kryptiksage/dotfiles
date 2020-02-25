#!/bin/bash

# network
export WLAN=$(ip link | grep wlp | awk -F ": " '{print $2}')
export ETH=$(ip link | grep enp | awk -F ": " '{print $2}')

killall -qw polybar

# Launch bars top and bottom
echo "---" | tee -a /tmp/polybar_top.log /tmp/polybar_bottom.log
#polybar top >>/tmp/polybar_top.log 2>&1 &
polybar bottom >>/tmp/polybar_bottom.log 2>&1 &

echo "Bars launched..."
