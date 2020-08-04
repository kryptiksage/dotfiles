#!/bin/sh

packages=(zsh xf86-video-intel picom reflector zsh-autosuggestions zsh-syntax-highlighting firefox code bluez bluez-utils pulseaudio-bluetooth zsh-theme-powerlevel10k nodejs yarn rustup rust-analyzer-bin telegram-desktop qbittorrent tree alacritty dmenu)

DOT_DIR=$(pwd)

# Install kop
curl -s -L https://git.io/JvyrA | bash

## Install essential packages
for i in "${packages[@]}"
do
	[ -z $(pacman -Qq $i 2>/dev/null) ] && sudo pacman -S --noconfirm $i 
done

# zsh
echo "Switching to zsh"
[ $(echo $SHELL) != /bin/zsh ] && chsh -s /bin/zsh
echo "Changed shell to zsh"

sym=( .zshrc .fonts .config/{mpv,nvim} .p10k.zsh )
[ ! -d $HOME/.config ] && mkdir $HOME/.config

# Symlink after deleting existing
for i in "${sym[@]}"
do
	[ -e $HOME/$i ] && rm -rf $HOME/$i
	ln -s $(pwd)/$i $HOME/$i
done

## neovim
# rust
rustup default stable
source $HOME/.config/nvim/init.vim 2>/dev/null
nvim +PlugInstall +"call coc#util#install()" +q +q
cd $HOME/.config/nvim/plugged/coc.nvim ; yarn install
nvim +"CocInstall coc-rust-analyzer" +q +q

# Wallpaper
mkdir $HOME/Pictures
cp $(pwd)/wallpaper.jpg $HOME/Pictures/

source $HOME/.zshrc 2>/dev/null
