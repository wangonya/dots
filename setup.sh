set -e

echo "=== syncing time ==="
sudo timedatectl set-ntp true
echo

echo "=== running updates ==="
sudo pacman-mirrors -f 10
sudo pacman -Syyuu
echo

echo "=== installing packages ==="
sudo pacman -S --needed redshift nodejs npm yarn zathura-pdf-mupdf qbittorrent hugo bat \
     postgresql redis ripgrep unclutter flameshot xarchiver pulseaudio python-rope \
     fd go go-tools gopls delve mariadb python-pip pandoc pulseaudio-alsa python-poetry \
     gparted dosfstools mtools unzip mpv youtube-dl pulseaudio-jack pavucontrol \
     python-build python-wheel python-isort python-lsp-server tela-icon-theme \
     firefox alacritty stylua python-debugpy base-devel yay prettier
echo

echo "=== installing aur stuff ==="
#gpg --recv-key 2D347EA6AA65421D
#gpg --recv-key 2954CC8585E27A3F
#gpg --recv-key 5E3C45D7B312C643
yay -S ngrok slack-desktop spotify mictray zoom nvim-packer-git \
       beekeeper-studio-bin google-cloud-sdk phinger-cursors \
       python-darker nerd-fonts-roboto-mono ly neovim-git \
      
echo

echo "=== starting and enabling systemd services ==="
systemctl enable redis.service
systemctl start redis.service

sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
systemctl enable mariadb.service
systemctl start mariadb.service

systemctl disable lightdm.service
systemctl enable ly.service
echo

echo "=== setting up npm system wide install config ==="
echo PATH="$HOME/.node_modules/bin:$PATH" >> ~/.profile
echo export npm_config_prefix=~/.node_modules >> ~/.profile
source ~/.profile
echo

echo "=== setting up dotfiles ==="
mv ~/.i3/config ~/.i3/config.bak
ln -sv ~/dots/i3wm/i3 ~/.i3/config

mv ~/.config/dunst/dunstrc ~/.config/dunst/dunstrc.bak
ln -sv ~/dots/i3wm/dunstrc ~/.config/dunst

ln -sv ~/dots/i3wm/i3status.conf ~/.i3status.conf

git clone https://gist.github.com/wandernauta/6800547
chmod +x 6800547/sp
sudo mv 6800547/sp /usr/local/bin
rm -rf 6800547

mv ~/.Xresources ~/.Xresources.bak
ln -sv ~/dots/i3wm/Xresources ~/.Xresources

mv ~/.dmenurc ~/.dmenurc.bak
ln -sv ~/dots/i3wm/dmenurc ~/.dmenurc

ln -sv ~/dots/python/pdbrc ~/.pdbrc

ln -sv ~/dots/terminals/alacritty.yml ~/.config/

echo "source ~/dots/terminals/zshrc" >> ~/.zshrc
echo "corner-radius = 5" >> ~/.config/picom.conf

ln -sv ~/dots/nvim/ ~/.config/nvim

git clone https://github.com/mantissa-/mantis-theme.git --depth=1
mv mantis-theme/Mantis* ~/.themes
echo

echo "=== setting up git configs"
git config --global init.defaultBranch main
git config --global core.excludesFile '~/dots/git/gitignore'
git config --global credential.helper store
echo

#setup postgres
#setup mariadb

# https://github.com/andreasgrafen/cascade#how-to-use-a-userchromecss-theme
# ln -sv ~/dots/firefox-css/chrome ~/.mozilla/firefox/...
