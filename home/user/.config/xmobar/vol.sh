#!/bin/bash
# shellcheck disable=2155

declare sink_vol="蓼 "
declare -r default_sink_mute="$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')"
declare -r default_sink_vol="$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')"

if [[ "${default_sink_mute}" == yes ]]; then
    sink_vol+="-"
else
    sink_vol+="${default_sink_vol}"
fi

declare -r default_source_mute="$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')"
declare -r default_source_vol="$(pactl get-source-volume @DEFAULT_SOURCE@ | awk '{print $5}')"

declare -r default_source="$(pactl get-default-source)"

declare -r state="$(pactl list short sources | awk -v ds="${default_source}" '$2 == ds {print $7}')"

declare source_vol=""

if [[ "${default_source_mute}" != "yes" && "${default_source_vol}" != "0%" && "${state}" != "SUSPENDED" ]]; then
    source_vol="<fc=red> ${default_source_vol}</fc>"
elif [[ "${state}" == "SUSPENDED" ]]; then
    source_vol=" off"
else
    source_vol=" mute"
fi

echo "<fc=#81A1C1> · </fc> ${sink_vol} ${source_vol}"
