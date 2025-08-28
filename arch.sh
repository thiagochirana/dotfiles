#!/usr/bin/env bash
set -euo pipefail

echo ">>> Atualizando sistema..."
sudo pacman -Syu --noconfirm

############################################################
# SYSTEM (system.sh)
############################################################
echo ">>> Instalando pacotes base..."
sudo pacman -S --noconfirm --needed \
    base-devel git curl wget unzip inetutils \
    vim neovim zsh bat eza fzf ripgrep fd zoxide jq \
    fontconfig noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-liberation ttf-font-awesome

# yay
if ! command -v yay >/dev/null 2>&1; then
  echo ">>> Instalando yay..."
  cd /tmp
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
fi

############################################################
# DRIVERS (drivers.sh)
############################################################
echo ">>> Instalando drivers AMD..."
sudo pacman -S --noconfirm --needed \
    linux-headers mesa lib32-mesa \
    vulkan-radeon lib32-vulkan-radeon \
    vulkan-icd-loader lib32-vulkan-icd-loader \
    libva-mesa-driver lib32-libva-mesa-driver \
    mesa-vdpau lib32-mesa-vdpau \
    egl-wayland qt5-wayland qt6-wayland

############################################################
# HYPRLAND (hyprland.sh)
############################################################
echo ">>> Instalando ambiente Hyprland..."
yay -S --noconfirm --needed \
    brightnessctl playerctl pamixer wireplumber \
    fcitx5 fcitx5-gtk fcitx5-qt wl-clip-persist \
    nautilus sushi ffmpegthumbnailer \
    slurp satty mpv evince imv \
    chromium wl-screenrec swayosd hyprsunset localsend-bin

mkdir -p ~/.config/hypr
cat > ~/.config/hypr/hyprland.conf <<'EOF'
# Configurações para AMD
env = LIBVA_DRIVER_NAME,mesa
env = VDPAU_DRIVER,va_gl
EOF

############################################################
# APPS (apps.sh)
############################################################
echo ">>> Instalando apps úteis..."
yay -S --noconfirm --needed \
    alacritty btop fastfetch tldr man \
    gnome-keyring polkit-gnome \
    docker docker-compose docker-buildx \
    python-terminaltexteffects yaru-icon-theme \
    fprintd usbutils libfido2 pam-u2f

sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"

############################################################
# BLUETOOTH (bluetooth.sh)
############################################################
echo ">>> Instalando Bluetooth..."
sudo pacman -S --noconfirm --needed bluez bluez-utils blueman
sudo systemctl enable --now bluetooth

############################################################
# FONTS (fonts.sh)
############################################################
echo ">>> Instalando Nerd Fonts..."
yay -S --noconfirm --needed ttf-cascadia-mono-nerd ttf-ia-writer

############################################################
# DEV TOOLS (dev.sh)
############################################################
echo ">>> Instalando ferramentas de desenvolvimento..."
yay -S --noconfirm --needed \
    cargo clang llvm mise imagemagick \
    mariadb-libs postgresql-libs \
    github-cli lazygit lazydocker-bin \
    heroku-cli-bin valkey

# mise
if ! grep -q "mise activate zsh" ~/.zshrc 2>/dev/null; then
  echo 'eval "$(mise activate zsh)"' >> ~/.zshrc
fi

############################################################
# ZSH CONFIG (zsh.sh)
############################################################
echo ">>> Instalando Oh My Zsh + plugins..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Copia o .zshrc completo
cat > ~/.zshrc <<'EOF'
(SEU ZSHRC COMPLETO AQUI)
EOF

############################################################
# GITHUB SSH (github.sh)
############################################################
echo ">>> Configurando SSH para GitHub..."
mkdir -p ~/.ssh
cd ~/.ssh
ssh-keygen -t ed25519 -C "github" -f github -N ""
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/github
echo ">>> Chave SSH gerada:"
cat ~/.ssh/github.pub

############################################################
# FINAL (finish.sh)
############################################################
yay -Syu --noconfirm --ignore uwsm

echo ">>> Instalação concluída! Reinicie o sistema."
