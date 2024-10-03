#!/bin/zsh
# shellcheck shell=bash

export LANG="en_US.UTF-8"

export SHELL="/bin/zsh"
export EDITOR=nvim
export SUDO_EDITOR="nvim"
export DIFFPROG="nvim -d"
export PATH="${PATH}:${HOME}/.local/bin"
export PATH="${PATH}:/opt/homebrew/opt"
export PATH="${PATH}:/opt/homebrew/opt/libtool/libexec/gnubin"

export STARSHIP_CONFIG="${HOME}/.config/zsh/starship.toml"

export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-c"

export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
export HOMEBREW_NO_ANALYTICS=1

source "$HOME/.cargo/env"
