set -e

echo "=== syncing time ==="
sudo timedatectl set-ntp true
echo

echo "=== running updates ==="
sudo pacman -Syyuu
echo

echo "=== installing packages ==="
yay -S --needed zathura-pdf-mupdf deluge-gtk hugo bat polybar udiskie \
    postgresql redis ripgrep unclutter xarchiver pulseaudio python-rope \
    fd go go-tools gopls delve mariadb python-pip pulseaudio-alsa p7zip \
    dosfstools mtools unzip mpv youtube-dl pulseaudio-jack pavucontrol \
    python-build python-wheel python-isort python-lsp-server bspwm sxhkd \
    firefox alacritty stylua python-debugpy base-devel prettier xorg \
    acpilight aria2 dunst xorg-xinit lxappearance htop rofi xdotool \
    pcmanfm zsh zsh-completions tree zsh-theme-powerlevel10k zoom mime \
    zsh-syntax-highlighting zsh-history-substring-search zsh-autosuggestions \
    slack-desktop nvim-packer-git pulseaudio-control clipit lsof nodejs \
    beekeeper-studio-bin google-cloud-sdk networkmanager-dmenu-git emptty \
    mpd ncmpcpp mpc python-darker neovim-git \
echo

echo "=== starting and enabling systemd services ==="
systemctl enable redis

sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
systemctl enable mariadb

systemctl enable --user mpd

systemctl enable emptty
sudo mv /etc/emptty/conf /etc/emptty/conf.bak
sudo cp ~/dots/emptty/conf /etc/emptty/conf
echo

echo "=== setting up dotfiles ==="

mkdir ~/.config/dunst
ln -sv ~/dots/dunst/dunstrc ~/.config/dunst/dunstrc

mkdir ~/.config/rofi
ln -sv ~/dots/rofi/config.rasi ~/.config/rofi/config.rasi
ln -sv ~/dots/rofi/colors.rasi ~/.config/rofi/colors.rasi

ln -sv ~/dots/mpd/ ~/.config/
mkdir -p ~/.mpd/playlists

mkdir ~/.config/ncmpcpp
mkdir ~/.ncmpcpp-previews
ln -sv ~/dots/ncmpcpp/config ~/.config/ncmpcpp/config
sudo ln -s ~/dots/ncmpcpp/music.sh /bin/music

ln -sv ~/dots/nvim/ ~/.config/nvim

ln -sv ~/dots/networkmanager-dmenu ~/.config/networkmanager-dmenu

ln -sv ~/dots/python/pdbrc ~/.pdbrc

ln -sv ~/dots/terminals/zshrc ~/.zshrc

ln -sv ~/dots/terminals/alacritty.yml ~/.alacritty.yml

cp ~/dots/fonts ~/.local/share

echo "=== setting up git configs"
git config --global init.defaultBranch main
git config --global core.excludesFile '~/dots/git/gitignore'
git config --global credential.helper store
echo

#setup postgres
#setup mariadb

# https://github.com/andreasgrafen/cascade#how-to-use-a-userchromecss-theme
# ln -sv ~/dots/firefox-css/chrome ~/.mozilla/firefox/...

install -Dm755 ~/dots/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
install -Dm755 ~/dots/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
install -Dm755 ~/dots/bspwm/external-rules.sh ~/.config/bspwm/external-rules.sh

# gpasswd -a kelvin video

# .Xresources -> #include "dots/x/Xresources"

# sudo vim /etc/X11/xorg.conf.d/30-touchpad.conf
# Section "InputClass"
#     Identifier "touchpad"
#     Driver "libinput"
#     MatchIsTouchpad "on"
#     Option "Tapping" "on"
#     Option "TappingButtonMap" "lmr"
# EndSection
