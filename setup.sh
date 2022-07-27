set -e

echo "=== syncing time ==="
sudo timedatectl set-ntp true
echo

echo "=== running updates ==="
sudo pacman-mirrors -f 10
sudo pacman -Syyuu
echo

echo "=== installing packages ==="
sudo pacman -S --needed nodejs npm zathura-pdf-mupdf qbittorrent hugo bat \
     postgresql redis ripgrep unclutter flameshot xarchiver pulseaudio python-rope \
     fd go go-tools gopls delve mariadb python-pip pandoc pulseaudio-alsa python-poetry \
     gparted dosfstools mtools unzip mpv youtube-dl pulseaudio-jack pavucontrol \
     python-build python-wheel python-isort python-lsp-server tela-icon-theme \
     firefox alacritty stylua python-debugpy base-devel yay prettier hsetroot \
     mpd ncmpcpp mpc acpilight aria2 picom dunst
echo

echo "=== installing aur stuff ==="
yay -S slack-desktop nvim-packer-git catppuccin-gtk-theme \
       beekeeper-studio-bin google-cloud-sdk phinger-cursors networkmanager-dmenu-git \
       python-darker nerd-fonts-roboto-mono ly neovim-git rofi-power-menu ngrok zoom\
      
echo

echo "=== starting and enabling systemd services ==="
systemctl enable redis.service
systemctl start redis.service

sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
systemctl enable mariadb.service
systemctl start mariadb.service

# systemctl disable lightdm.service
# systemctl enable ly.service

systemctl enable mpd.service
systemctl start mpd.service
echo

echo "=== setting up npm system wide install config ==="
echo PATH="$HOME/.node_modules/bin:$PATH" >> ~/.profile
echo export npm_config_prefix=~/.node_modules >> ~/.profile
source ~/.profile
echo

echo "=== setting up dotfiles ==="
mv ~/.i3/config ~/.i3/config.bak
ln -sv ~/dots/i3wm/i3 ~/.i3/config

ln -sv ~/dots/dunst ~/.config

ln -sv ~/dots/i3wm/i3status.conf ~/.i3status.conf

ln -sv ~/dots/rofi/ ~/.config/

ln -sv ~/dots/python/pdbrc ~/.pdbrc

ln -sv ~/dots/terminals/alacritty.yml ~/.config/

ln -sv ~/dots/mpd/ ~/.config/
mkdir -p ~/.mpd/playlists


ln -sv ~/dots/ncmpcpp ~/.config/

echo "source ~/dots/terminals/zshrc" >> ~/.zshrc
echo "rounded-corners-exclude = [\"window_type = 'dock'\"];" >> ~/.config/picom.conf
echo "corner-radius = 5" >> ~/.config/picom.conf

ln -sv ~/dots/nvim/ ~/.config/nvim

ln -sv ~/dots/networkmanager-dmenu ~/.config

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

# slack theme: #1E1E2E,#2D3136,#1F2A42,#D8DCE8,#45475A,#CDD6F4,#A6E3A1,#89B4FA,#131020,#CDD6F4

# .Xresources -> #include "dots/x/Xresources"
