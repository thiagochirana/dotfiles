#!/bin/bash

sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm eza bat zsh uwsm fftw alsa-lib iniparser pkgconf gtklock
sudo pacman -S --needed --noconfirm swayosd satty

yay -S --needed --noconfirm zsh-theme-powerlevel10k-git