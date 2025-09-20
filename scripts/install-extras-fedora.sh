# new hyprland install script

# paths/variables
dfextra=$HOME/dotfiles/.extra

#  ____
# |  _ \ ___ _ __   ___  ___
# | |_) / _ \ '_ \ / _ \/ __|
# |  _ <  __/ |_) | (_) \__ \
# |_| \_\___| .__/ \___/|___/
#           |_|
# Copr
sudo dnf -y copr enable solopasha/hyprland # hyprland
sudo dnf -y copr enable alternateved/eza # eza
sudo dnf -y copr enable erikreider/SwayNotificationCenter # swaync

#  _   _                  _                 _
# | | | |_   _ _ __  _ __| | __ _ _ __   __| |
# | |_| | | | | '_ \| '__| |/ _` | '_ \ / _` |
# |  _  | |_| | |_) | |  | | (_| | | | | (_| |
# |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_|
#        |___/|_|
# Hyprland core and important stuff

# hyprland core, python, waypaper, waybar, rofi, nmcli/tui, swaync, alacritty
sudo dnf -y hyprland python waypaper waybar rofi NetworkManager-tui SwayNotificationCenter alacritty

#  _________  _   _
# |__  / ___|| | | |
#   / /\___ \| |_| |
#  / /_ ___) |  _  |
# /____|____/|_| |_|
#
# ZSH

# install zsh and eza (replaces ls)
sudo dnf -y install zsh eza
# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && zsh -c './install-extras-fedora.sh'
# clone oh-my-zsh plugins into their proper place
sudo git clone https://github.com/chrissicool/zsh-256color ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-256color # zsh-256color
sudo git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions # zsh-autosuggestions
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting # zsh-syntax-highlighting
sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k # oh-my-zsh p10k install


#  _____           _
# |  ___|__  _ __ | |_ ___
# | |_ / _ \| '_ \| __/ __|
# |  _| (_) | | | | |_\__ \
# |_|  \___/|_| |_|\__|___/
#
#Fonts

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

#  ____            _
# / ___| _   _ ___| |_ ___ _ __ ___
# \___ \| | | / __| __/ _ \ '_ ` _ \
#  ___) | |_| \__ \ ||  __/ | | | | |
# |____/ \__, |___/\__\___|_| |_| |_|
#        |___/
# Less important system stuff

# pywal16
pip3 install pywal16
# pywalfox
pip install pywalfox
pywalfox install
# nwg-displays clone + install
sudo git clone https://github.com/nwg-piotr/nwg-displays /opt/nwg-displays
cd /opt/nwg-displays
sudo ./install.sh

#  _____ _
# |_   _| |__   ___ _ __ ___   ___  ___
#   | | | '_ \ / _ \ '_ ` _ \ / _ \/ __|
#   | | | | | |  __/ | | | | |  __/\__ \
#   |_| |_| |_|\___|_| |_| |_|\___||___/
#
# Themes

# breeze-gtk (file explorer dark mode support)
sudo dnf -y install breeze-gtk
