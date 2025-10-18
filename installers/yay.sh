#!/bin/bash

tmpdir=$(mktemp -d)
cd "$tmpdir"
 git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ~
rm -rf "$tmpdir"