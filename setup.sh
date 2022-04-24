set -e

echo "=== running updates ==="
sudo pacman-mirrors -f 10
sudo pacman -Syyu
echo

echo "=== installing packages ==="
sudo pacman -S redshift nodejs npm yarn zathura-pdf-mupdf qbittorrent hugo bat \
     postgresql redis ripgrep unclutter flameshot pulseaudio pulseaudio-alsa \
     fd go go-tools gopls delve mariadb pavucontrol python-pip emacs pandoc \
     gparted dosfstools mtools unzip mpv youtube-dl pulseaudio-equalizer-ladspa \
     python-build python-wheel python-isort python-lsp-server
echo

echo "=== installing aur stuff ==="
gpg --recv-key 2D347EA6AA65421D
pamac build ngrok slack-desktop spotify we10x-icon-theme-git xarchiver \
      visual-studio-code-bin beekeeper-studio-bin python37 google-cloud-sdk \
      orchis-theme python-darker \
      
echo

echo "=== starting and enabling systemd services ==="
systemctl enable redis.service
systemctl start redis.service

sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
systemctl enable mariadb.service
systemctl start mariadb.service
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

git clone https://gist.github.com/wandernauta/6800547
chmod +x 6800547/sp
sudo mv 6800547/sp /usr/local/bin
sp
rm -rf 6800547

mkdir .config/pudb
ln -sv ~/dots/python/pudb.cfg .config/pudb

mv ~/.Xresources ~/.Xresources.bak
ln -sv ~/dots/i3wm/Xresources ~/.Xresources

mv ~/.dmenurc ~/.dmenurc.bak
ln -sv ~/dots/i3wm/dmenurc ~/.dmenurc

ln -sv ~/dots/python/pdbrc ~/.pdbrc

echo "source ~/dots/terminals/zshrc" >> ~/.zshrc
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

# mkdir .emacs.d
# ln -sv ~/dots/emacs/init.el ~/.emacs.d/init.el
# git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
# ~/.emacs.d/bin/doom install
# rm -rf ~/.doom.d/
# ln -sv ~/dots/emacs ~/.doom.d
# ~/.emacs.d/bin/doom sync
# sh -c 'sh -c "$(curl -sL https://nextdns.io/install)"'
