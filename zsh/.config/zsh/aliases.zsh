#!/bin/zsh
# shellcheck shell=bash

alias fd="fd --unrestricted"
alias ip="ip -color=auto"
alias rg="rg --smart-case --unrestricted"
alias sudo="sudo "
alias v=nvim
alias vim=nvim
alias vimdiff="nvim -d"

alias wrs2303="studio-cli --profile=wrs2303"
alias wrs2309="studio-cli --profile=wrs2309"

alias cargo-build-arm="cargo build --target aarch64-unknown-linux-musl --config target.aarch64-unknown-linux-musl.linker=\\\"aarch64-linux-gnu-gcc\\\""
