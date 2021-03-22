#!/bin/sh

# Package List
packages=(alacritty bluez bluez-utils code firefox grim reflector pulseaudio-bluetooth qbittorrent sway telegram-desktop waybar wdisplays zsh zsh-theme-powerlevel10k)

# Package Install
for i in "${packages[@]}"
do
	pacman -Qq $i 2>/dev/null || sudo pacman -S --noconfirm $i 
done

# Zsh
echo "Changing Shell"
[[ "$SHELL" == *"zsh"* ]] && chsh -s /bin/zsh
echo "Shell changed to zsh"

# Symlink 
sym=(.config/{alacritty,nvim,sway,waybar} .fonts .p10k.zsh .zshrc)

