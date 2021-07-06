#!/bin/sh

# Package List
packages=(alacritty bat bluez bluez-utils exa firefox grim kdeconnect nodejs pulseaudio-bluetooth qbittorrent reflector rustup rust-analyzer slurp sway telegram-desktop waybar wdisplays yarn zsh zsh-autosuggestions zsh-completions zsh-theme-powerlevel10k)

# Package Install
for i in "${packages[@]}"
do
	pacman -Qq $i 2>/dev/null || sudo pacman -S --noconfirm $i 
done

# Zsh
echo "Changing Shell"
[[ "$SHELL" == *"zsh"* ]] || chsh -s /bin/zsh
echo "Shell changed to zsh"

# Symlink 
sym=(.config/{alacritty,nvim,sway,waybar} .fonts .p10k.zsh .zshrc)
for i in "${sym[@]}"
do
	if [ -e $i ]
	then
		rm -rf $HOME/$i
		ln -s $PWD/$i $HOME/$i
	fi
done

# Wallpaper
[ ! -e ~/Pictures/wallpaper.jpg ] || rm -rf ~/Pictures/wallpaper.jpg
[ -e ~/Pictures ] || mkdir ~/Pictures
ln -s $PWD/wallpaper.jpg ~/Pictures/wallpaper.jpg

# Rust
rustup toolchain install stable

# Time
sudo systemctl --now enable systemd-timesyncd.service
timedatectl set-timezone Asia/Kolkata
sudo hwclock --systohc
