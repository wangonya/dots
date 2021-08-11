echo "=== running updates ==="
sudo pacman -Syyu
echo

echo "=== installing packages ==="
sudo pacman -S redshift nodejs npm yarn vim zathura-pdf-mupdf qbittorrent postgresql redis kitty ripgrep unclutter flameshot bat hugo rlwrap fd emacs shfmt go go-tools gopls texlive-core texlive-latexextra tidy ttf-jetbrains-mono python-pip
echo

echo "=== starting and enabling systemd services ==="
systemctl start redis.service
systemctl enable redis.service
echo

echo "=== installing aur stuff ==="
yay -S insomnia-bin spotify beekeeper-studio-bin bash-git-prompt
echo

echo "=== installing python stuff ==="
pip3 install pylint isort ipython ipdb black pipenv wakatime
echo

echo "=== setting up npm system wide install config ==="
echo PATH="$HOME/.node_modules/bin:$PATH" >>~/.profile
echo export npm_config_prefix=~/.node_modules >>~/.profile
source ~/.profile
echo

echo "=== installing npm stuff ==="
npm i -g prettier pyright
echo

echo "=== setting up dotfiles ==="
mv ~/.config/bspwm/ ~/.config/bspwm.bak
ln -sv ~/dots/bspwm/ ~/.config/bspwm

mv ~/.config/polybar/ ~/.config/polybar.bak
ln -sv ~/dots/polybar/ ~/.config/polybar

mv ~/.config/sxhkd/ ~/.config/sxhkd.bak
ln -sv ~/dots/sxhkd/ ~/.config/sxhkd

cp ~/dots/terminals/kitty.conf ~/.config/kitty/

echo "source ~/dots/terminals/bashrc" >>~/.bashrc
echo

echo "=== setting up git configs"
git config --global init.defaultBranch main
ln -sv ~/dots/gitignore ~/.gitignore
git config --global core.excludesfile ~/.gitignore
echo

echo "=== setting up emacs ==="
[ -d ~/.emacs.d ] && mv ~/.emacs.d ~/.emacs.d-bak
git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
[ -d ~/.doom.d ] && mv ~/.doom.d ~/.doom.d-bak
ln -sv ~/dots/emacs/doom.d/ ~/.doom.d
echo

#setup postgres
