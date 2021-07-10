echo "=== running updates ==="
sudo pacman -Syyu
echo

echo "=== installing packages ==="
sudo pacman -S firefox redshift nodejs npm yarn neovim python-neovim zathura-pdf-mupdf qbittorrent postgresql redis alacritty ripgrep unclutter pulseaudio pulseaudio-alsa pavucontrol flameshot bat hugo ctags unzip clojure leiningen jdk-openjdk rlwrap fd emacs shfmt go go-tools gopls elixir texlive-core
echo

echo "=== starting and enabling systemd services ==="
systemctl start redis.service
systemctl enable redis.service
echo

echo "=== installing aur stuff ==="
pamac build nerd-fonts-jetbrains-mono insomnia-bin neovim-nightly-bin clojure-lsp-bin
echo

echo "=== installing python stuff ==="
pip install pylint isort flake8 ipython ipdb black
pip install 'python-lsp-server[all]'
echo

echo "=== installing rust ==="
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo

echo "=== installing poetry ==="
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
echo

echo "=== setting up npm system wide install config ==="
echo PATH="$HOME/.node_modules/bin:$PATH" >>~/.profile
echo export npm_config_prefix=~/.node_modules >>~/.profile
source ~/.profile
echo

echo "=== installing npm stuff ==="
npm i -g prettier node-cljfmt
echo

echo "=== installing vim plug ==="
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
echo

echo "=== setting up dotfiles ==="
mkdir -p ~/.config/alacritty
ln -sv ~/dots/alacritty.yml ~/.config/alacritty/alacritty.yml

git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
ln -sv ~/dots/nvim ~/.config/

mv ~/.i3/config ~/.i3/config.bkp
ln -sv ~/dots/i3 ~/.i3/config

mv .dmenurc .dmenurc.bak
ln -sv ~/dots/dmenurc .dmenurc

ln -sv ~/dots/i3status.conf ~/.i3status.conf

chmod +x ~/dots/i3status-net-speed.sh

ln -sv ~/dots/python/flake8 ~/.config/flake8
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
ln -sv ~/dots/gitignore ~/.gitignore
git config --global core.excludesfile ~/.gitignore
echo

echo "=== setting up lua"
git clone https://github.com/sumneko/lua-language-server
cd lua-language-server
git submodule update --init --recursive

cd 3rd/luamake
compile/install.sh
cd ../..
./3rd/luamake/luamake rebuild

mkdir .cache/nvim/lspconfig/sumneko_lua
cp lua-language-server .cache/nvim/lspconfig/sumneko_lua -r

luarocks install --server=https://luarocks.org/dev luaformatter
echo

echo "=== setting up emacs ==="
[ -d ~/.emacs.d ] && mv ~/.emacs.d ~/.emacs.d-bak
git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
ln -sv ~/dots/emacs/doom.d/ .doom.d
echo

# pamac build bcwc-pcie-git && sudo modprobe facetimehd - for webcam driver if on mac
