#!/bin/zsh
# shellcheck shell=bash

# zsh
# ==================================================================================================

export KEYTIMEOUT=1

source "${ZDOTDIR}/environment.zsh"
source "${ZDOTDIR}/vi-mode.zsh"
source "${ZDOTDIR}/fzf.zsh"
source "${ZDOTDIR}/aliases.zsh"
source "${ZDOTDIR}/hashes.zsh"
source "${ZDOTDIR}/functions.zsh"
source "${ZDOTDIR}/ls_colors"

# grml + starship config: https://github.com/starship/starship/issues/4198
prompt off
eval "$(starship init zsh)"

# load "edit cmd line" widget
autoload -z edit-command-line
zle -N edit-command-line

# enable vi-mode
bindkey -v

# key bindings
bindkey "" edit-command-line # ctrl-e to edit cmd line

# start windows manager if on tty1
# ==================================================================================================

if [[ -z ${DISPLAY} && $(tty) = /dev/tty1 ]]; then
    export BROWSER="/usr/bin/brave"
    export XCURSOR_PATH=""
    export XCURSOR_SIZE=16
    export GTK_OVERLAY_SCROLLING=0
    export _JAVA_AWT_WM_NONREPARENTING=1
    export MOZ_WEBRENDER=1

    sx
fi
