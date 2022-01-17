echo "=== running updates ==="
sudo xbps-install -Su
echo

echo "=== installing packages ==="
sudo xbps-install -S i3-gaps git chromium rofi redshift nodejs \
     npm yarn zathura-pdf-mupdf qbittorrent postgresql redis \
     alacritty ripgrep unclutter flameshot hugo fd go go-tools \
     gopls delve ttf-ibm-plex mariadb zsh neovim
echo

echo "=== installing external libs ==="
# pamac build lua-format ngrok google-cloud-sdk

curl -L git.io/antigen > antigen.zsh
echo

echo "=== starting and enabling systemd services ==="
sudo ln -s /etc/sv/redis.service /var/service/

sudo ln -s /etc/sv/mysqld /var/service
sudo mysql_secure_installation
echo

echo "=== installing python stuff ==="
pip install isort darker wakatime pynvim cookiecutter pipenv build
pip install 'python-lsp-server[all]'
echo

echo "=== setting up npm system wide install config ==="
echo PATH="$HOME/.node_modules/bin:$PATH" >> ~/.profile
echo export npm_config_prefix=~/.node_modules >> ~/.profile
source ~/.profile
echo

echo "=== installing npm stuff ==="
npm i -g prettier pyright vscode-langservers-extracted
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

[-f .config/nvim ] && mv .config/nvim .config/nvim.bak
ln -sv ~/dots/nvim ~/.config/nvim
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
