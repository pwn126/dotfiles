#!/bin/bash

set -eE -o pipefail

while true; do
    waybar || {
        echo "Waybar crashed!" | systemd-cat --identifier="waybar" --priority=err

        hyprland_pid=$(ps x |rg Hyprland | awk '$5 == "Hyprland" {print $1}')

        if [[ -z "${hyprland_pid}" ]]; then
            return 0
        fi

        sleep 1
    }
done
