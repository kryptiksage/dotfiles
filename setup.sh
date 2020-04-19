#/bin/sh/
git clone --depth=1 https://github.com/kryptiksage/dotfiles.git
cd dotfiles
echo "Exec permission for install.sh"
chmod +x install.sh
./install.sh
