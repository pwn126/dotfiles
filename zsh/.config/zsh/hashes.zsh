#!/bin/zsh
# shellcheck shell=bash

hash -dr
hash -d log=/var/log
hash -d config=${HOME}/.config
hash -d nvim=${HOME}/.config/nvim
hash -d downloads=${HOME}/downloads
hash -d tmp=${HOME}/tmp

hash -d apps=/home/user/src/sva/platform/examles/applications
hash -d src=/home/user/src

hash -d wrlinux=/home/user/src/bsp/wrlinux/22.09
hash -d wrlinux-apps=/home/user/src/bsp/wrlinux/22.09.apps
hash -d wrl2310=/home/user/src/bsp/wrlinux/raspi_lts23_10

hash -d meta-aptiv=/home/user/src/bsp/wrlinux/22.09/layers/meta-aptiv
hash -d meta-apps=/home/user/src/bsp/wrlinux/22.09.apps/layers/meta-apps
hash -d meta-ota-apps=/home/user/src/mwd_internal/over-the-air/meta-ota-apps
hash -d meta-raspi-gw=/home/user/src/mwd_internal/over-the-air/meta-raspi-gw

hash -d compose=/home/user/src/docker/compose
hash -d win_home=/mnt/c/Users/sjbh9k
hash -d ota=/home/user/src/mwd_internal/over-the-air
hash -d amt=/home/user/src/mwd/autosar-migration-toolkit
