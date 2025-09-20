#!/bin/bash
# Complete installer and configuration script for Niri.
# Written for Fedora

# Repos
sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm # fusion free
sudo dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm # fusion nonfree
sudo dnf -y copr enable yalter/niri # niri
sudo dnf -y copr enable solopasha/hyprland # hypr utilities
sudo dnf -y copr enable alternateved/eza # eza

# Tools
sudo dnf -y install libnotify qt5-qtwayland qt6-qtwayland python-pip python3-pip nm-connection-editor network-manager-applet fuse ImageMagick NetworkManager-tui flatpak fastfetch figlet
# enable flathub repo to flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Niri DWM
sudo dnf -y install niri

# ZSH and utilities
sudo dnf -y install zsh eza
# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && zsh -c './setup-script.sh'
# clone oh-my-zsh plugins into their proper place
sudo git clone https://github.com/chrissicool/zsh-256color ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-256color # zsh-256color
sudo git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions # zsh-autosuggestions
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting # zsh-syntax-highlighting
sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k # oh-my-zsh p10k install

# Hypr apps
sudo dnf -y install hyprlock

# Waypaper and waybar
sudo dnf -y install waypaper waybar

# Thunderbird
sudo dnf -y install thunderbird

# Discord, Plex, Spotify (flatpaks)
flatpak -y install flathub com.discordapp.Discord
flatpak -y install flathub tv.plex.PlexDesktop
flatpak -y install flathub com.spotify.Client

# Wlogout
sudo dnf -y install wlogout

# Kate
sudo dnf -y install kate

# pywal and pywalfox
# pywal16
pip3 install pywal16
# pywalfox
pip install pywalfox
pywalfox install

# Fonts (incl with dotfiles dl)
# create fonts and sorting directories
mkdir $HOME/.fonts
mkdir $HOME/.fonts/m
# copy fonts from .extra and place in new font directories
cp $dfextra/MesloLGS*.ttf $HOME/.fonts/m
# create .font.config file
echo "<?xml version=\"1.0\"?><!DOCTYPE fontconfig SYSTEM \"fonts.dtd\">
<fontconfig>
 <dir>~/.fonts</dir>
</fontconfig>" > $HOME/.fonts.config

# Assign dark mode for gtk
dconf write /org/gnome/desktop/interface/color-scheme '"prefer-dark"'

# prevent wal lockup by assigning bg
cp $HOME/dotfiles/.extra/wallpaper.jpg /var/tmp/wp.png
wal -i /var/tmp/wp.png




