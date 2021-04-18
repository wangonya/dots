echo "=== running updates ==="
sudo pacman -Syyu
echo

echo "=== installing packages ==="
sudo pacman -S firefox redshift nodejs npm yarn neovim python-neovim zathura-pdf-mupdf qbittorrent postgresql redis alacritty ripgrep unclutter pulseaudio pulseaudio-alsa pavucontrol flameshot bat hugo ctags unzip
sudo pacman -Rns palemoon-bin
echo

echo "=== starting and enabling systemd services ==="
systemctl start redis.service
systemctl enable redis.service
echo

echo "=== installing aur stuff ==="
pamac build nerd-fonts-jetbrains-mono insomnia-bin neovim-nightly-bin
echo

echo "=== installing python stuff ==="
pip3 install pylint autopep8 isort flake8 ipython ipdb
echo

echo "=== installing rust ==="
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo

echo "=== installing poetry ==="
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
echo

echo "=== setting up npm system wide install config ==="
echo PATH="$HOME/.node_modules/bin:$PATH" >> ~/.profile
echo export npm_config_prefix=~/.node_modules >> ~/.profile
source ~/.profile
echo

echo "=== installing npm stuff ==="
npm i -g prettier
echo

echo "=== installing vim plug ==="
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
echo

echo "=== setting up dotfiles ==="
mkdir -p ~/.config/alacritty
ln -sv ~/dots/alacritty.yml ~/.config/alacritty/alacritty.yml

# mkdir -p ~/.config/nvim
# ln -sv ~/dots/nvim.vim ~/.config/nvim/init.vim
# ln -sv ~/dots/coc-settings.json ~/.config/nvim/coc-settings.json
ln -sv ~/dots/nvim .config/

chmod +x ~/dots/light.sh
sudo ln -sv ~/dots/light.sh /etc/profile.d/light.sh

mv ~/.i3/config ~/.i3/config.bkp
ln -sv ~/dots/i3 ~/.i3/config

mv .dmenurc .dmenurc.bak
ln -sv ~/dots/dmenurc .dmenurc

ln -sv ~/dots/i3status.conf ~/.i3status.conf

chmod +x ~/dots/i3status-net-speed.sh
echo

echo "=== installing oh-my-bash ==="
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
echo

echo "=== updating bashrc ==="
mv ~/.bashrc ~/.bashrc.bkp
ln -sv ~/dots/bashrc ~/.bashrc
echo

echo "=== setting up git configs"
git config --global init.defaultBranch main
echo

# pamac build bcwc-pcie-git && sudo modprobe facetimehd - for webcam driver if on mac
