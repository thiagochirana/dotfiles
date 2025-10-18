#!/bin/bash

sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm base-devel libyaml git curl postgresql postgis eza bat zsh uwsm fftw alsa-lib iniparser pkgconf gtklock
sudo pacman -S --needed --noconfirm swayosd hyprpicker satty hyprshot