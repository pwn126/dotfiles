#!/bin/zsh
# shellcheck shell=bash

export SHELL="/usr/bin/zsh"
# export LIBVA_DRIVER_NAME="vdpau"
# export VDPAU_DRIVER="nvidia"
export EDITOR=nvim
export SUDO_EDITOR="nvim"
export DIFFPROG="nvim -d"
export PATH="${PATH}:${HOME}/.cargo/bin"
export SYSTEMD_EDITOR=nvim

export STARSHIP_CONFIG="${HOME}/.config/zsh/starship.toml"

export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-c"
