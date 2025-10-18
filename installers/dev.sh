#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

sudo pacman -S --needed --noconfirm base-devel libyaml git curl postgresql postgis mise vim neovim valkey

yay -S --needed --noconfirm windsurf ngrok

$DOTFILES_DIR/installers/devs/postgresql.sh
$DOTFILES_DIR/installers/devs/redis.sh
