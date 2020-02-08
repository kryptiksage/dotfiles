#!/bin/bash

power=$(bluetoothctl show |  grep 'Powered' | cut -c 11-)
if [ "$power" = "no" ]
then
	bluetoothctl power on
else
	bluetoothctl power off
fi
