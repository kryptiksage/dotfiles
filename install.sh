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

# Bluetooth
chmod +x $HOME/.config/i3/bluet.sh

# Switch default displays
cp .xprofile $HOME/.xprofile
echo -n "Switch to HDMI (y/n) : " 
read display
while true
do
	case $display in
		y | Y)
		echo export DISP_VAR='"$(xrandr --output eDP-1 --off --output HDMI-1 --primary)"' > $HOME/.xprofile
		echo Display set to HDMI
		break
		;;
		n | N)
		echo Display set to default
		break
		;;
	esac
done
source $HOME/.xprofile

# Apply .Xresources
xrdb .Xresources

# i3
i3-msg restart

source $HOME/.zshrc 2>/dev/null
