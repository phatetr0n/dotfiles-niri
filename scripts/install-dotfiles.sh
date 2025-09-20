#!/bin/bash
# install dotfiles for specified program list

# List of program directories to strip and link
dirs=("hypr" "alacritty" "waybar" "wlogout" "fastfetch" "waypaper" "wal" "niri" "easyeffects" )

# Base paths
config_dir="$HOME/.config"
dotfiles_dir="$HOME/dotfiles"

# zshrc
rm $HOME/.zshrc
ln $dotfiles_dir/.zshrc $HOME/.zshrc

# p10k
rm $HOME/.p10k.zsh
ln $dotfiles_dir/.p10k.zsh $HOME/.p10k.zsh

# Loop through the directories
for dir in "${dirs[@]}"; do
    # Full paths
    config_path="$config_dir/$dir"
    dotfiles_path="$dotfiles_dir/$dir"

    # Check if the config directory exists and remove it
    if [ -d "$config_path" ]; then
        echo "Removing existing directory: $config_path"
        rm -rf "$config_path"
    else
        echo "No existing directory to remove: $config_path"
    fi

    # Create symlink to the dotfiles directory
    echo "Creating symlink: $config_path -> $dotfiles_path"
    ln -s "$dotfiles_path" "$config_path"
done

echo "Done!"
