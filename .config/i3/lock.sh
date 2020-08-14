#!/bin/sh
rm /tmp/lock* 2>/dev/null
scrot /tmp/lock_screen.png
i3lock -i /tmp/lock_screen.png

