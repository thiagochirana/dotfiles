echo "⚙️  Configurando dotfiles..."

# Diretórios base
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"
BIN_DIR="$HOME/.local/bin"

mkdir -p "$CONFIG_DIR" "$BIN_DIR"

# --- Hyprland ---
if [ -d "$CONFIG_DIR/hypr" ]; then
  echo "🧹 Removendo configuração antiga de Hyprland..."
  rm -rf "$CONFIG_DIR/hypr"
fi

echo "🔗 Criando symlink para Hyprland..."
ln -s "$DOTFILES_DIR/dots/hypr" "$CONFIG_DIR/hypr"

# --- Zsh ---
echo "🔗 Criando symlink para Zsh..."
rm "$HOME/.zshrc"
ln -s "$DOTFILES_DIR/dots/zsh/.zshrc" "$HOME/.zshrc"

# --- Binários ---
echo "⚙️  Configurando binários..."
chmod +x "$DOTFILES_DIR/bin/"*
for file in "$DOTFILES_DIR/bin/"*; do
  ln -sf "$file" "$BIN_DIR/$(basename "$file")"
done

echo
echo "✅ Dotfiles configurados!"
echo
echo "✅ Instalação concluída com sucesso!"