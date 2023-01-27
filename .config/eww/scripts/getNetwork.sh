#!/bin/sh

SSID=$(iwgetid -r)
[[ "$SSID" = "FIOS-HWMMS" ]] && SSID="HS-Student"

case $1 in
	"icon")
		[[ $(cat /sys/class/net/w*/operstate) = down ]] && echo "󰤫" || echo "󰤪"
		;;
	"name")
		[[ -z "$SSID" ]] && echo "Wi-Fi" || echo "$SSID"
		;;
	"trname")
		[[ -z "$SSID" ]] && echo "Wi-Fi" || echo "${SSID::13}..."
		;;
	"color")
		[[ $(cat /sys/class/net/w*/operstate) = down ]] && echo "$bgSecondary" || echo "#1c2325"
		;;
esac
