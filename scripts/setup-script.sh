#!/bin/bash
# Complete installer and configuration script for Niri.
# Written for Fedora

cat <<"EOF"
       _           _               _      _            _
 _ __ | |__   __ _| |_ ___   _ __ (_)_ __(_)  ___  ___| |_ _   _ _ __
| '_ \| '_ \ / _` | __/ _ \ | '_ \| | '__| | / __|/ _ \ __| | | | '_ \
| |_) | | | | (_| | ||  __/ | | | | | |  | | \__ \  __/ |_| |_| | |_) |
| .__/|_| |_|\__,_|\__\___| |_| |_|_|_|  |_| |___/\___|\__|\__,_| .__/
|_|                                                             |_|

EOF

# repos
repo=(
   https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
   https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
)

# copr repos
copr=(
   yalter/niri
   solopasha/hyprland
   alternateved/eza
)

# general purpose tools or libraries used by other stuff
tools=(
   libnotify
   qt5-qtwayland
   qt6-qtwayland
   python-pip
   python3-pip
   nm-connection-editor
   network-manager-applet
   fuse
   ImageMagick
   NetworkManager-tui
   flatpak
   fastfetch
   figlet
   xclip
   git
)

# stuff core to the customized dwm
core=(
   niri
   zsh
   eza
   hyprlock
   waypaper
   waybar
   wlogout
)

# extra utilities
extra=(
   thunderbird
   kate
)

# flatpaks
flatpaks=(
   com.discordapp.Discord
   tv.plex.PlexDesktop
   com.spotify.Client
)

# enable copr repositories
echo "Enabling COPR repos and other third party repositories..."
for acopr in "${copr[@]}"; do
   sudo dnf -y copr enable "$acopr"
done

# install repos
for arepo in "${repo[@]}"; do
   sudo dnf -y install "$arepo"
done

# install core, tools, and extra packages
echo "Installing packages..."
sudo dnf -y install "${core[@]}" "${tools[@]}" "${extra[@]}"

# add flatpak repo and install flatpaks
echo "Enabling flatpak repo and installing flatpaks..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
for aflatpaks in "${flatpaks[@]}"; do
   flatpak install -y flathub "$aflatpaks"
done

# install oh-my-zsh then clone plugins
echo "Installing oh-my-zsh and plugins..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && zsh -c './setup-script.sh'
git clone https://github.com/chrissicool/zsh-256color \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-256color"
git clone https://github.com/zsh-users/zsh-autosuggestions \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

# pywal16 and pywalfox
echo "Installing python tools..."
pip3 install pywal16
pip install pywalfox
pywalfox install

# create font directory for fonts I use and install
echo "Creating font directory and config..."
mkdir -p "$HOME/.fonts/m"
cp "$HOME/dotfiles/.extra"/MesloLGS*.ttf "$HOME/.fonts/m"
cat > "$HOME/.fonts.conf" <<EOF
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <dir>$HOME/.fonts</dir>
</fontconfig>
EOF

# assign dark mode for gtk
echo "Assigning dark mode for gtk..."
dconf write /org/gnome/desktop/interface/color-scheme '"prefer-dark"'

# prevent wal lockup by assigning bg
echo "Copying background..."
cp "$HOME/dotfiles/.extra/wallpaper.jpg" /var/tmp/wp.png
wal -i /var/tmp/wp.png

echo "Done!"
