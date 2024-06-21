#!/bin/sh
marks=$(swaymsg -t get_marks)
IFS=$'\n' allmarks=( $marks )
length=${#allmarks[@]}

echo $length
if [[ $(( $length < 1 )) ]];then
	echo "0 0 0"
fi
