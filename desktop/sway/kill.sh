#!/bin/sh
file="/tmp/scratchpad"
current=$(cat "$file" | awk '{print $1}')
total=$(cat "$file" | awk '{print $2}')
mark=$(swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true) | .marks[0]')

if [[ $mark != null ]]; then
	if [[ $current == $(( $total-1 )) ]]; then
		swaymsg "[con_mark=\"sp$current\"] kill"
		total=$(( $total-1 ))
		current=$(( $current - 1 ))
		if [[ $(( $current < 0 )) ]];then
			current=0
		fi
	else
		swaymsg "[con_mark=\"sp$current\"] kill"
		total=$(( $total-1 ))
		swaymsg -- "[con_mark=\"sp$total\"] mark --replace sp$current"
	fi
	echo "$current $total 0" > $file

else
	swaymsg kill
fi
