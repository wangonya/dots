echo "=== running updates ==="
sudo xbps-install -Su
echo

echo "=== installing packages ==="
sudo xbps-install -S i3-gaps i3lock i3status git firefox dmenu redshift nodejs \
     yarn zathura-pdf-mupdf qbittorrent postgresql redis fzf curl xorg-fonts \
     alacritty ripgrep unclutter flameshot hugo fd go xorg-minimal bat \
     gopls delve font-ibm-plex-ttf mariadb zsh neovim xf86-video-intel \
     python3-devel python3-pip iwd lua-devel luarocks cmake wget pulseaudio \
     zsh-autosuggestions zsh-syntax-highlighting zsh-completions chrony \
     xarandr arandr nitrogen alsa-utils pavucontrol v4l-utils v4l2loopback \
     alsa-plugins-pulseaudio
echo

echo "=== installing external libs ==="
# pamac build lua-format ngrok google-cloud-sdk
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

luarocks install --server=https://luarocks.org/dev luaformatter --local

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo

echo "=== starting and enabling systemd services ==="
sudo ln -s /etc/sv/{redis,mysqld,pulseaudio,iwd} /var/service
sudo modprobe v4l2loopback # webcam -- creates /dev/video0
echo

echo "=== fix fonts ==="
sudo ln -s /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d
sudo xbps-reconfigure -f fontconfig
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

ln -sv ~/dots/i3wm/i3 ~/.i3/config

ln -sv ~/dots/i3wm/i3status.conf ~/.i3status.conf

mv .zshrc .zshrc.bak
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

echo "=== set timezone ==="
sudo ln -sf /usr/share/zoneinfo/Africa/Nairobi /etc/localtime
sudo ln -s /etc/sv/chronyd /var/service
echo

#setup postgres
#setup mariadb

# sudo visudo add:
# user_name ALL=(ALL) NOPASSWD: /bin/poweroff, /bin/reboot, /bin/shutdown

# alsa headphones fix
# /etc/modprobe.d/alsa-base.conf
# options snd-pcsp index=-2
# alias snd-card-0 snd-hda-intel
# alias sound-slot-0 snd-hda-intel
# options snd-hda-intel model=laptop
# options snd-hda-intel position_fix=1 enable=yes
