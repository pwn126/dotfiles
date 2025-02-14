#!/bin/bash

set -eE -o pipefail

declare -r dev="14:28:76:CC:67:C1"

bluetoothctl disconnect "$dev" || true

sleep 2

if bluetoothctl connect "$dev"; then
    notify-send --icon=audio-volume-medium "Airpods connected"
else
    notify-send --icon=audio-volume-medium --urgency=critical "Airpods connection failed"
fi
