#!/usr/bin/env bash
set -euo pipefail

# Função para verificar se um pacote está instalado
is_installed() {
    pacman -Qi "$1" &> /dev/null
}

echo ">>> Atualizando o sistema e habilitando multilib..."
sudo pacman -Syu --noconfirm

# Habilitar multilib se não estiver habilitado
if ! grep -q "^\[multilib\]" /etc/pacman.conf; then
    echo "Habilitando repositório multilib..."
    sudo sed -i '/^#\[multilib\]/,/^#Include/ s/^#//' /etc/pacman.conf
    sudo pacman -Syu --noconfirm
fi

# Atualizar chaves do pacman
echo "Atualizando chaves do pacman..."
sudo pacman-key --refresh-keys

# Instalar pacotes básicos do sistema
echo ">>> Instalando pacotes básicos..."
sudo pacman -S --needed --noconfirm \
    git curl vim neovim \
    base-devel fakeroot \
    man-db man-pages \
    openssh wget rsync \
    htop btop iotop iftop \
    unzip unrar p7zip \
    bash-completion \
    mlocate \
    dosfstools ntfs-3g \
    networkmanager network-manager-applet \
    bluez bluez-utils \
    pulseaudio pulseaudio-alsa pulseaudio-bluetooth \
    alsa-utils \
    xdg-user-dirs xdg-utils \
    gvfs gvfs-mtp \
    udisks2 udiskie \
    ntfs-3g \
    exfat-utils \
    dosfstools \
    eza bat ripgrep fd fzf \
    hwloc hwinfo \
    lshw \
    lm_sensors \
    dmidecode \
    neofetch \
    wget curl \
    rsync \
    unzip unrar p7zip \
    tree \
    jq \
    yajl \
    bc \
    lsof \
    nmap \
    whois \
    dnsutils \
    bind-tools \
    traceroute \
    iptables-nft \
    ipset \
    iptables \
    nftables \
    ufw \
    fail2ban \
    rng-tools \
    haveged \
    cronie \
    logrotate \
    sysstat \
    iotop-c \
    iotop \
    iftop \
    nethogs \
    bmon \
    iptraf-ng \
    mtr \
    tcpdump \
    wireshark-qt \
    ethtool \
    bridge-utils \
    openvpn

# Habilitar serviços essenciais
sudo systemctl enable --now bluetooth
sudo systemctl enable --now systemd-resolved
sudo systemctl enable --now systemd-timesyncd
sudo systemctl enable --now cronie
sudo systemctl enable --now fstrim.timer

# Configurações básicas do sistema
echo "Configurando localização e teclado..."
sudo timedatectl set-ntp true
sudo localectl set-locale LANG=pt_BR.UTF-8
sudo localectl set-x11-keymap br

# Criar diretórios de usuário se não existirem
xdg-user-dirs-update


echo "Configuração básica do sistema concluída!"
