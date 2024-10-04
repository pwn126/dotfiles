#!/bin/zsh
# shellcheck shell=bash

export SHELL="/usr/bin/zsh"
export LIBVA_DRIVER_NAME="vdpau"
export VDPAU_DRIVER="nvidia"
export EDITOR=nvim
export SUDO_EDITOR="nvim"
export DIFFPROG="nvim -d"
export PATH="${PATH}:${HOME}/.local/bin"
export SYSTEMD_EDITOR=nvim

export XMONAD_CONFIG_DIR="${XDG_CONFIG_HOME}/xmonad"
export XMONAD_DATA_DIR="${XDG_DATA_HOME}/xmonad"
export XMONAD_CACHE_DIR="${XMONAD_DATA_DIR}"

export STARSHIP_CONFIG="${HOME}/.config/zsh/starship.toml"
