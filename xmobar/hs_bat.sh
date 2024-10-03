#!/bin/bash
# shellcheck disable=2155

declare -r hs_bat=$(dbus-send --print-reply=literal --system --dest=org.bluez /org/bluez/hci0/dev_08_C8_C2_3E_44_94 org.freedesktop.DBus.Properties.Get string:"org.bluez.Battery1" string:"Percentage" | awk '{print $3}')

if [[ -n "${hs_bat}" ]]; then
    if [[ ${hs_bat} -le 10 ]]; then
        echo "<fc=red> ${hs_bat}%</fc>"
    else
        echo " ${hs_bat}%"
    fi
else
    echo " -"
fi
