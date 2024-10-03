#!/bin/bash

if [[ $(networkctl | awk '$2 ~ "wg0" {print $4}') == *routable* ]]; then
    kitty --app-id kitty-vpn --title "Disable VPN connection" \
        zsh -c "echo 'Disable VPN connection' && sudo networkctl down wg0"
else
    kitty --app-id kitty-vpn --title "Enable VPN connection" \
        zsh -c "echo 'Enable VPN connection' && sudo networkctl up wg0"
        sudo networkctl up wg0
fi
