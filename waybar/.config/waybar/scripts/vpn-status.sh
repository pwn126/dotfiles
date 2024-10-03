#!/bin/bash

if [[ $(networkctl | awk '$2 ~ "wg0" {print $4}') == *routable* ]]; then
    echo '{"text": "VPN", "class": "up"}'
fi

echo '{"text": "", "tooltip": ""}'
