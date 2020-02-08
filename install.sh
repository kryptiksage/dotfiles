#!/bin/bash

sym=( .vimrc .Xresources .zshrc .fonts .config/{i3,polybar,rofi} .p10k.zsh )
[ ! -d $HOME/.config ] && mkdir $HOME/.config

# Symlink after deleting existing
for i in "${sym[@]}"
do
	[ -e $HOME/$i ] && rm -rf $HOME/$i
	ln -s $(pwd)/$i $HOME/$i
done

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k 2>/dev/null

# zsh
sudo pacman -S zsh-autosuggestions zsh-syntax-highlighting
source $HOME/.zshrc 2>/dev/null

chmod +x $HOME/.config/i3/bluet.sh
# Apply .Xresources
xrdb .Xresources

# i3
i3-msg restart
