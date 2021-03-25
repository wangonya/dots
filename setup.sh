echo "=== running updates ==="
sudo pacman -Syyu
echo

echo "=== installing packages ==="
sudo pacman -S firefox chromium redshift nodejs npm yarn neovim python-neovim zathura-pdf-mupdf qbittorrent postgresql redis alacritty ripgrep
echo

echo "=== starting and enabling systemd services ==="
systemctl start redis.service
systemctl enable redis.service
echo

echo "=== installing aur stuff ==="
pamac build nerd-fonts-jetbrains-mono
echo

echo "=== installing python stuff ==="
pip3 install pylint yapf isort
echo

echo "=== installing rust ==="
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo

echo "=== installing oh-my-bash ==="
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
echo

echo "=== setting up dotfiles ==="
mkdir -p ~/.config/alacritty
ln -sv ~/dots/alacritty.yml ~/.config/alacritty/alacritty.yml

mkdir -p ~/.config/nvim
ln -sv ~/dots/nvim.vim ~/.config/nvim/init.vim

chmod +x ~/dots/light.sh
sudo ln -sv ~/dots/light.sh /etc/profile.d/light.sh
echo
