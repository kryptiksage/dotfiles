#!/bin/sh

# Colors
NOCOLOR='\033[0m'
ORANGE='\033[0;33m'
GREEN='\033[0;32m'

# Package List
packages=(alacritty bat bluez bluez-utils exa firefox grim kdeconnect nodejs pulseaudio-bluetooth qbittorrent reflector rustup rust-analyzer slurp sway telegram-desktop waybar wdisplays xdg-desktop-portal xdg-desktop-portal-wlr yarn zathura zathura-pdf-mupdf zsh zsh-autosuggestions zsh-completions zsh-theme-powerlevel10k)

# Package Install
echo "${ORANGE}Installing packages${NOCOLOR}"
for i in "${packages[@]}"
do
	pacman -Qq $i 2>/dev/null || sudo pacman -S --noconfirm $i 
done
echo "${GREEN}Installed${NOCOLOR}"

# Zsh
echo "${ORANGE}Changing Shell${NOCOLOR}"
[[ "$SHELL" == *"zsh"* ]] || chsh -s /bin/zsh
echo "${GREEN}Shell changed to zsh${NOCOLOR}"

# Symlink 
echo "${ORANGE}Symlinking dotfiles${NOCOLOR}"
sym=(.config/{alacritty,nvim,sway,waybar} .fonts .p10k.zsh .zshrc)
for i in "${sym[@]}"
do
	if [ -e $i ]
	then
		rm -rf $HOME/$i
		ln -s $PWD/$i $HOME/$i
	fi
done
echo "${GREEN}Symlink done${NOCOLOR}"

# Wallpaper
echo "${ORANGE}Changing wallpaper${NOCOLOR}"
[ ! -e ~/Pictures/wallpaper.jpg ] || rm -rf ~/Pictures/wallpaper.jpg
[ -e ~/Pictures ] || mkdir ~/Pictures
ln -s $PWD/wallpaper.jpg ~/Pictures/wallpaper.jpg
echo "${GREEN}Default wallpaper linked${NOCOLOR}"

# Rust
echo "${ORANGE}Installing rust stable toolchain${NOCOLOR}"
rustup toolchain install stable
echo "${GREEN}Rust installed${NOCOLOR}"

# Time
echo "${ORANGE}Setting timezone/time${NOCOLOR}"
sudo systemctl --now enable systemd-timesyncd.service
timedatectl set-timezone Asia/Kolkata
sudo hwclock --systohc
echo "${GREEN}Timezone set${NOCOLOR}"
