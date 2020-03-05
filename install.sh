#!/bin/bash

packages=(zsh rxvt-unicode xf86-video-intel i3-gaps i3blocks i3lock i3status dmenu rofi picom reflector zsh-autosuggestions zsh-syntax-highlighting)

# Install essential packages
for i in "${packages[@]}"
do
	[ $(pacman -Qq $i 2>/dev/null | wc -l) -eq 0 ] && sudo pacman -S $i 
done

# zsh
echo "Switching to zsh"
[ $(echo $SHELL) != /bin/zsh ] && chsh -s /bin/zsh
echo "Changed shell to zsh"

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
		echo export DISP_VAR='"$(xrandr --output eDP1 --off --output HDMI1 --primary)"' > $HOME/.xprofile
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

# Wallpaper
cp $(pwd)/wallpaper.jpg $HOME/Pictures/

# Apply .Xresources
xrdb .Xresources

# i3
i3-msg restart

source $HOME/.zshrc 2>/dev/null
