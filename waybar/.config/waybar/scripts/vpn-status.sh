#!/bin/bash

if [[ $(networkctl | awk '$2 ~ "wg0" {print $4}') == *routable* ]]; then
    echo '{"text": "vpn", "class": "up"}'
else
    echo '{"text": "vpn", "class": "down"}'
fi
