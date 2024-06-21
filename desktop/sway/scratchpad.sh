#!/bin/sh
file="/tmp/scratchpad"

marks=$(swaymsg -t get_marks | jq '.[0]')

if [[ $marks == null ]]; then
	echo "0 0 0" > $file
fi

current=$(cat "$file" | awk '{print $1}')
total=$(cat "$file" | awk '{print $2}')
shown=$(cat "$file" | awk '{print $3}')
visible=$(swaymsg -t get_tree | jq '.. | select(.type?) | select(.type=="floating_con") | select(.visible==true) | select(.marks[0]!=null) | .marks[0]')

if [[ $1 == "add" ]]; then
	if [[ $shown == 1 ]]; then
	  	swaymsg "[con_mark=\"sp$current\"] scratchpad show"
		shown=0
	fi
	swaymsg -- mark --toggle "sp$total", move scratchpad
	total=$(( $total+1 ))
	shown=0
else
	if [[ $shown == 0 ]]; then
	  	swaymsg "[con_mark=\"sp$current\"] scratchpad show"
		shown=1
	else
	  	swaymsg "[con_mark=\"sp$current\"] scratchpad show"
		current=$(( (($current+1)%$total) ))
		shown=0
	fi
fi
echo "$current $total $shown" > $file
