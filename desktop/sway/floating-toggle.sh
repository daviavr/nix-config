#!/bin/sh
file="/tmp/scratchpad"
current=$(cat "$file" | awk '{print $1}')
total=$(cat "$file" | awk '{print $2}')
mark=$(swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true) | .marks[0]')

if [[ $mark != null ]]; then
	if [[ $(( $current - $total )) == 1 ]]; then
		swaymsg "unmark sp$current"
		total=$(( $total-1 ))
		current=$(( $current % $total ))
	else
		swaymsg "unmark sp$current"
		total=$(( $total-1 ))
		swaymsg -- "[con_mark=\"sp$total\"] mark --replace sp$current"
	fi
	echo "$current $total 0" > $file
fi
swaymsg "floating toggle"
