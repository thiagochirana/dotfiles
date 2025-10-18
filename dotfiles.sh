#!/usr/bin/env zsh

echo "⚙️  Configurando dotfiles..."

set -euo pipefail
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"
BIN_DIR="$HOME/.local/bin"

mkdir -p "$CONFIG_DIR" "$BIN_DIR"
mkdir -p "$HOME/Screenshots"

# --- Zsh ---
echo "🔗 Criando symlink para Zsh..."
rm -f "$HOME/.zshrc"
ln -s "$DOTFILES_DIR/dots/zsh/.zshrc" "$HOME/.zshrc"

source "$HOME/.zshrc"

# --- powerlevel10k ---
echo "🔗 Criando symlink para powerlevel10k..."
rm -rf "$HOME/.p10k.zsh"
ln -s "$DOTFILES_DIR/dots/p10k/.p10k.zsh" "$HOME/.p10k.zsh"

# --- Hyprland ---
echo "🔗 Criando symlink para Hyprland..."
rm -rf "$CONFIG_DIR/hypr"
ln -s "$DOTFILES_DIR/dots/hypr" "$CONFIG_DIR/hypr"

# --- Binários ---
echo "⚙️  Configurando binários..."
BIN_DIR="$HOME/.local/bin"

mkdir -p "$BIN_DIR"

chmod +x "$DOTFILES_DIR/bin/"*
for file in "$DOTFILES_DIR/bin/"*; do
  target="$BIN_DIR/$(basename "$file")"
  echo "🔗 $target"
  ln -s "$file" "$target"
done


# --- Waybar ---
echo "🔗 Criando symlink para Waybar..."
rm -rf "$CONFIG_DIR/waybar"
ln -s "$DOTFILES_DIR/dots/waybar" "$CONFIG_DIR/waybar"

# --- GTKLock ---
echo "🔗 Criando symlink para GTKLock..."
rm -rf "$CONFIG_DIR/gtklock"
ln -s "$DOTFILES_DIR/dots/gtklock" "$CONFIG_DIR/gtklock"

# --- Walker ---
echo "🔗 Criando symlink para Walker..."
rm -rf "$CONFIG_DIR/walker"
ln -s "$DOTFILES_DIR/dots/walker" "$CONFIG_DIR/walker"

hyprctl reload

echo
echo "✅ Dotfiles configurados!"
echo
echo "✅ Instalação concluída com sucesso!"
pkill -SIGUSR2 waybar