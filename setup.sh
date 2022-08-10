set -e

echo "=== running updates ==="
xbps-install -Su
echo

echo "=== installing packages ==="
sudo xbps-install zathura-pdf-mupdf deluge-gtk hugo bat xorg \
    ripgrep unclutter maim tar p7zip pulseaudio pavucontrol \
    fd go go-tools gopls delve python3-pip pulseaudio-alsa  \
    unzip mpv youtube-dl pulseaudio-jack python3-lsp-server \
    firefox rxvt-unicode StyLua base-devel hsetroot acpilight aria2 \
    dunst void-repo-nonfree rofi bspwm sxhkd zsh-autosuggestions \
    zsh-completions zsh-history-substring-search zsh-syntax-highlighting \
    neovim spacefm clipit gtk+3 NetworkManager polybar \
    zlib zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel xz libffi-devel
echo

echo "=== installing external libs ==="
# pamac build lua-format ngrok google-cloud-sdk
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# slack, zoom, etc
echo

echo "=== starting and enabling runit services ==="
sudo ln -s /etc/sv/{dbus,pulseaudio,NetworkManager} /var/service
echo

echo "=== fix fonts ==="
sudo ln -s /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d
sudo xbps-reconfigure -f fontconfig
echo

echo "=== installing python stuff ==="
curl https://pyenv.run | bash
pip install isort darker wheel build rope
echo

echo "=== setting up dotfiles ==="
ln -sv ~/dots/dunst ~/.config

ln -sv ~/dots/rofi/ ~/.config/

ln -sv ~/dots/python/pdbrc ~/.pdbrc

ln -sv ~/dots/terminals/zshrc ~/.zshrc

ln -sv ~/dots/gtk/mountain ~/.themes

ln -sv ~/dots/nvim/ ~/.config/nvim

ln -sv ~/dots/networkmanager-dmenu ~/.config

ln -sv ~/dots/fonts ~/.local/share/fonts

cp ~/dots/x/xinitrc ~/.xinitrc

git clone https://github.com/mountain-theme/icons.git ~/.local/share/icons/mountain-icons --depth=1

echo "=== setting up git configs"
git config --global init.defaultBranch main
git config --global core.excludesFile '~/dots/git/gitignore'
git config --global credential.helper store
echo

#setup postgres
#setup mariadb

# https://github.com/andreasgrafen/cascade#how-to-use-a-userchromecss-theme
# ln -sv ~/dots/firefox-css/chrome ~/.mozilla/firefox/...

# install -Dm755 ~/dots/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
# install -Dm755 ~/dots/sxhkdrc/sxhkdrc ~/.config/sxhkd/sxhkdrc
# install -Dm755 ~/dots/bspwm/external-rules.sh ~/.config/bspwm/external-rules.sh

# gpasswd -a kelvin video

# .Xresources -> #include "dots/x/Xresources"
