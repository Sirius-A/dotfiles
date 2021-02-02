#!/bin/sh

# Select audio devices via rofi
# Source: https://github.com/jfaltis/useful-menus/blob/master/audio-devices.sh

selection=$(
	pactl list short sinks | 
	sed "s/RUNNING/a/g; s/IDLE/b/g; s/SUSPENDED/c/g; s/alsa_output.//g" |
	sort -k7 | 
	awk '{print $2}') 

#grep the sink id from selection
selected="$( 
	pactl list short sinks | 
	grep $(echo "$selection" | 
		rofi -dmenu -p "sink" -i -l $(echo "$selection" | wc -l)) | # use as many lines as sinks exist 
		#dmenu -m 0 -i -l $(echo "$selection" | wc -l)) | # use as many lines as sinks exist 
		awk '{print $1}')" 

pactl set-default-sink $selected # set default sink

# Move each audio stream to new sink
pactl list short sink-inputs|while read stream; do 
	streamId=$(echo $stream|cut '-d ' -f1)
	pactl move-sink-input "$streamId" "$selected"
done
