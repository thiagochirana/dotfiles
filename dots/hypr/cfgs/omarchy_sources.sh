#!/bin/bash

exec = bash -c '
source_if_exists() {
  [ -f "$1" ] && hyprctl source "$1"
}

source_if_exists ~/.local/share/omarchy/default/hypr/autostart.conf
source_if_exists ~/.local/share/omarchy/default/hypr/bindings/media.conf
source_if_exists ~/.local/share/omarchy/default/hypr/bindings/tiling.conf
source_if_exists ~/.local/share/omarchy/default/hypr/bindings/utilities.conf
source_if_exists ~/.local/share/omarchy/default/hypr/envs.conf
source_if_exists ~/.local/share/omarchy/default/hypr/looknfeel.conf
source_if_exists ~/.local/share/omarchy/default/hypr/input.conf
source_if_exists ~/.local/share/omarchy/default/hypr/windows.conf
'