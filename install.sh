#!/bin/sh

packages=(zsh rxvt-unicode xf86-video-intel i3-gaps i3blocks i3lock i3status dmenu rofi picom reflector zsh-autosuggestions zsh-syntax-highlighting firefox code bluez bluez-utils pulseaudio-bluetooth zsh-theme-powerlevel10k mupdf nodejs yarn rustup rust-analyzer-bin)

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

sym=( .Xresources .zshrc .fonts .config/{i3,polybar,rofi,mpv,nvim} .p10k.zsh )
[ ! -d $HOME/.config ] && mkdir $HOME/.config

# Symlink after deleting existing
for i in "${sym[@]}"
do
	[ -e $HOME/$i ] && rm -rf $HOME/$i
	ln -s $(pwd)/$i $HOME/$i
done

# st
git clone https://github.com/kryptiksage/st.git $HOME/.config/st || (cd $HOME/.config/st ; git pull)
cd $HOME/.config/st
echo "Installing st..."
sudo make clean install
[ -f $HOME/.zshenv ] && sed -i '/export TERMINAL*/d' $HOME/.zshenv
echo TERMINAL=st >> $HOME/.zshenv

# dwm
git clone https://github.com/kryptiksage/dwm.git $HOME/.config/dwm || (cd $HOME/.config/dwm ; git pull)
cd $HOME/.config/dwn
echo "Installing dwn..."
sudo make clean install

## neovim
# rust
rustup default stable
source $HOME/.config/nvim/init.vim 2>/dev/null
nvim +PlugInstall +"call coc#util#install()" +q +q
nvim +"CocInstall coc-rust-analyzer" +q +q

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
