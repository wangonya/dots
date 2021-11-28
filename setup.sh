echo "=== running updates ==="
sudo pacman-mirrors -f 10
sudo pacman -Syyu
echo

echo "=== installing packages ==="
sudo pacman -S redshift nodejs npm yarn zathura-pdf-mupdf qbittorrent \
     postgresql redis alacritty ripgrep unclutter flameshot hugo \
     fd go go-tools gopls ttf-ibm-plex mariadb zsh neovim \
echo

echo "=== starting and enabling systemd services ==="
systemctl start redis.service
systemctl enable redis.service

sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
systemctl start mariadb.service
systemctl enable mariadb.service
echo

echo "=== installing aur stuff ==="
pamac build google-chrome antigen
echo

echo "=== installing python stuff ==="
pip3 install isort darker wakatime pynvim jedi pylint cookiecutter
echo

echo "=== setting up npm system wide install config ==="
echo PATH="$HOME/.node_modules/bin:$PATH" >> ~/.profile
echo export npm_config_prefix=~/.node_modules >> ~/.profile
source ~/.profile
echo

echo "=== installing npm stuff ==="
npm i -g prettier pyright
echo

echo "=== setting up dotfiles ==="
ln -sv ~/dots/terminals/alacritty.yml ~/.alacritty.yml

mv .dmenurc .dmenurc.bak
ln -sv ~/dots/menus/dmenurc ~/.dmenurc

mv .i3/config .i3/config.bak
ln -sv ~/dots/i3wm/i3 ~/.i3/config

ln -sv ~/dots/i3wm/i3status.conf ~/.i3status.conf

[ -f .zshrc ] && mv .zshrc .zshrc.bak
ln -sv ~/dots/terminals/zshrc ~/.zshrc
chsh -s /usr/bin/zsh

git clone https://github.com/dracula/zathura ~/.config/zathura/

curl -sLf https://spacevim.org/install.sh | bash
mkdir -p ~/.Spacevim.d/autoload
[-f .SpaceVim.d/init.toml ] && mv .SpaceVim.d/init.toml .SpaceVim.d/init.toml.bak
ln -sv ~/dots/spacevim/init.toml ~/.SpaceVim.d/init.toml
ln -sv ~/dots/spacevim/myspacevim.vim ~/.SpaceVim.d/autoload/myspacevim.vim
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
