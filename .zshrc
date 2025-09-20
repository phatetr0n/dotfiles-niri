# fastfetch goes at top to allow it to have colour
fastfetch

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git zsh-256color zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Helpful aliases
alias ls='eza -lh  --icons=auto' # long list
alias l='eza -1   --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias figlet='~/dotfiles/scripts/figlet.sh' # figlet for ASCII
alias wp='waypaper' # manage wallpapers

# Additional aliases
alias shl='Hyprland' # start Hyprland; for use after tty login
alias vpn='~/dotfiles/scripts/vpn.sh' # vpn. uses cached exit node list for vpn selection. check script for more
alias npv='piactl disconnect' # take down vpn

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Pywal
cat ~/.cache/wal/sequences

# add .local/bin to $PATH for pywal16
export PATH=$HOME/.local/bin:$PATH
