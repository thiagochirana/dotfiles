

sudo pacman -S libyaml git curl zsh vim neovim fontconfig nerd-fonts noto-fonts-emoji ttf-font-awesome
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cd /tmp/
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
