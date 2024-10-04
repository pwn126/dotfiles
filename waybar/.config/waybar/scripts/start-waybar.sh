#!/bin/bash

set -eE -o pipefail

while true; do
    waybar || echo "Waybar crashed! Restarting!" | systemd-cat --identifier="waybar" --priority=err
done
