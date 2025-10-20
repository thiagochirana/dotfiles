echo "⚙️  Configuring dotfiles..."

set -euo pipefail
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"
BIN_DIR="$HOME/.local/bin"

mkdir -p "$CONFIG_DIR" "$BIN_DIR"
mkdir -p "$HOME/Screenshots"
mkdir -p "$HOME/.$USER/backgrounds"

# --- Zsh ---
chsh -s $(which zsh)
echo "🔗 create symlink to Zsh..."
rm -f "$HOME/.zshrc"
ln -s "$DOTFILES_DIR/dots/zsh/.zshrc" "$HOME/.zshrc"

# source "$HOME/.zshrc"

# --- powerlevel10k ---
echo "🔗 create symlink to powerlevel10k..."
rm -rf "$HOME/.p10k.zsh"
ln -s "$DOTFILES_DIR/dots/p10k/.p10k.zsh" "$HOME/.p10k.zsh"

# --- Hyprland ---
echo "🔗 create symlink to Hyprland..."
rm -rf "$CONFIG_DIR/hypr"
ln -s "$DOTFILES_DIR/dots/hypr" "$CONFIG_DIR/hypr"

# --- Binários ---
"./bins.sh"

# --- Waybar ---
echo "🔗 create symlink to Waybar..."
rm -rf "$CONFIG_DIR/waybar"
ln -s "$DOTFILES_DIR/dots/waybar" "$CONFIG_DIR/waybar"

# --- GTKLock ---
echo "🔗 create symlink to GTKLock..."
rm -rf "$CONFIG_DIR/gtklock"
ln -s "$DOTFILES_DIR/dots/gtklock" "$CONFIG_DIR/gtklock"

# --- Walker ---
echo "🔗 create symlink to Walker..."
rm -rf "$CONFIG_DIR/walker"
ln -s "$DOTFILES_DIR/dots/walker" "$CONFIG_DIR/walker"

# --- Mako notifications ---
echo "🔗 create symlink to Mako..."
rm -rf "$CONFIG_DIR/mako"
ln -s "$DOTFILES_DIR/dots/mako" "$CONFIG_DIR/mako"

# --- Alacritty ---
echo "🔗 create symlink to Alacritty..."
rm -rf "$CONFIG_DIR/alacritty"
ln -s "$DOTFILES_DIR/dots/alacritty" "$CONFIG_DIR/alacritty"

hyprctl reload

echo
echo "✅ Dotfiles configured!"
echo
echo "✅ Installation completed successfully!"
pkill -SIGUSR2 waybar
