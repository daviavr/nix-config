#!/bin/sh
ps axf | grep dropin | grep -v grep && swaymsg "[app_id=\"dropin\"] scratchpad show"
ps axf | grep dropin | grep -v grep || (swaymsg -- exec kitty --class dropin -T dropin && sleep 0.1 && swaymsg "[app_id=\"dropin\"] scratchpad show")
