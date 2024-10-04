#!/bin/bash

declare -ar ifaces=( "tun0" "wg0" )

declare iface_up=""
declare iface_ip=""

for iface in "${ifaces[@]}"; do
    iface_up="$(ip link show up dev "${iface}")"
    iface_ip="$(ip -4 -brief addr show dev "${iface}" | awk '{print $3}')"

    if [[ -n "${iface_ip}" && -n "${iface_up}" ]]; then
        echo "<fc=red> vpn </fc><fc=#81A1C1> · </fc>"
        exit 0
    fi
done
