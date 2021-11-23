echo "=== running updates ==="
sudo pacman-mirrors -f 10
sudo pacman -Syyu
echo

echo "=== installing packages ==="
sudo pacman -S redshift nodejs npm yarn vim zathura-pdf-mupdf qbittorrent \
     postgresql redis alacritty ripgrep unclutter flameshot bat hugo rlwrap \
     fd emacs shfmt go go-tools gopls \
     ttf-ibm-plex mariadb
echo

echo "=== starting and enabling systemd services ==="
systemctl start redis.service
systemctl enable redis.service

sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
systemctl start mariadb.service
systemctl enable mariadb.service
echo

echo "=== installing aur stuff ==="
pamac build insomnia-bin beekeeper-studio-bin bash-git-prompt google-chrome\
      redis-desktop-manager
echo

echo "=== installing python stuff ==="
pip3 install isort darker wakatime
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
ln -sv ~/dots/terminals/alacritty.yml ~/.alacritty.yml

mv .dmenurc .dmenurc.bak
ln -sv ~/dots/menus/dmenurc ~/.dmenurc

mv .i3/config .i3/config.bak
ln -sv ~/dots/i3wm/i3 ~/.i3/config

ln -sv ~/dots/i3wm/i3status.conf ~/.i3status.conf

echo "source ~/dots/terminals/bashrc" >> ~/.bashrc

git clone https://github.com/dracula/zathura ~/.config/zathura/
echo

echo "=== setting up git configs"
git config --global init.defaultBranch main
git config --global core.excludesFile '~/dots/git/gitignore'
echo

echo "=== installing python-poetry ==="
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
source $HOME/.poetry/env
echo

#setup postgres
#setup mariadb
