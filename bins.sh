echo "⚙️  Configurando binários..."
BIN_DIR="$HOME/.local/bin"
DOTFILES_DIR="$HOME/dotfiles"

mkdir -p "$BIN_DIR"

chmod +x "$DOTFILES_DIR/bin/"*
for file in "$DOTFILES_DIR/bin/"*; do
  target="$BIN_DIR/$(basename "$file")"
  echo "🔗 $target"
  ln -s "$file" "$target"
done