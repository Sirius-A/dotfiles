#!/bin/sh

# Select audio devices via rofi
# Inspired from: https://github.com/jfaltis/useful-menus/blob/master/audio-devices.sh

selection=$(
	pacmd list-sinks |
		grep "device.description\|index" |
		cut -d'"' -f 2 | # Only take the description value between the ""
		sed 'N;s/\n/: /' | # Merge index line and device description
		cut -d':' -f 2- # Cut away the "index:" text
)

selected=$(
	echo "$selection" |
	rofi -dmenu -p "sink" -i -l $(echo "$selection" | wc -l) |
	cut -d':' -f 1
)

pactl set-default-sink $selected # set default sink

# Move each audio stream to new sink
pactl list short sink-inputs|while read stream; do
	streamId=$(echo $stream|cut '-d ' -f1)
	pactl move-sink-input "$streamId" "$selected"
done
