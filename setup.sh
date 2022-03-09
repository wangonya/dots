set -e

echo "=== running updates ==="
sudo pacman-mirrors -f 10
sudo pacman -Syyu
echo

echo "=== installing packages ==="
sudo pacman -S redshift nodejs npm yarn zathura-pdf-mupdf qbittorrent zola bat \
     postgresql redis ripgrep unclutter flameshot pulseaudio pulseaudio-alsa \
     fd go go-tools gopls delve ttf-ibm-plex mariadb pavucontrol python-pip \
     gparted dosfstools mtools unzip mpv youtube-dl pulseaudio-equalizer-ladspa
echo

echo "=== installing aur stuff ==="
pamac build ngrok slack-desktop spotify we10x-icon-theme-git usql \
      visual-studio-code-bin 
echo

echo "=== starting and enabling systemd services ==="
systemctl start redis.service
systemctl enable redis.service

sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
systemctl start mariadb.service
systemctl enable mariadb.service
echo

echo "=== installing python stuff ==="
pip install darker[isort] build
echo

echo "=== setting up npm system wide install config ==="
echo PATH="$HOME/.node_modules/bin:$PATH" >> ~/.profile
echo export npm_config_prefix=~/.node_modules >> ~/.profile
source ~/.profile
echo

echo "=== installing npm stuff ==="
npm i -g prettier
echo

echo "=== setting up dotfiles ==="
mv ~/.i3/config ~/.i3/config.bak
ln -sv ~/dots/i3wm/i3 ~/.i3/config

ln -sv ~/dots/i3wm/i3status.conf ~/.i3status.conf

[ -f .zshrc ] && mv .zshrc .zshrc.bak
ln -sv ~/dots/terminals/zshrc ~/.zshrc
chsh -s /usr/bin/zsh

[-f .config/nvim ] && mv .config/nvim .config/nvim.bak
ln -sv ~/dots/nvim ~/.config/nvim
echo

echo "=== setting up git configs"
git config --global init.defaultBranch main
git config --global core.excludesFile '~/dots/git/gitignore'
git config --global credential.helper store
echo

echo "=== syncing time ==="
sudo timedatectl set-ntp true
echo

#setup postgres
#setup mariadb
#https://wiki.manjaro.org/index.php/Improve_Font_Rendering
