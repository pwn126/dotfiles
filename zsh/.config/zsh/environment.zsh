#!/bin/zsh
# shellcheck shell=bash

export LANG="en_US.UTF-8"

export SHELL="/bin/zsh"
export EDITOR=nvim
export SUDO_EDITOR="nvim"
export DIFFPROG="nvim -d"

export STARSHIP_CONFIG="${HOME}/.config/zsh/starship.toml"

export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-c"

export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}";
export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar";
export HOMEBREW_NO_ANALYTICS=1

export MANPATH="${HOMEBREW_PREFIX}/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH:-}";

export PATH="${PATH}:${HOME}/.cargo/bin"
export PATH="${PATH}:${HOMEBREW_PREFIX}/opt"
export PATH="${PATH}:${HOMEBREW_PREFIX}/bin"
export PATH="${PATH}:${HOMEBREW_PREFIX}/sbin"
export PATH="${PATH}:${HOMEBREW_PREFIX}/opt/libtool/libexec/gnubin"

source "$HOME/.cargo/env"
