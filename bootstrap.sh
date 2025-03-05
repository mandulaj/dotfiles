#!/bin/bash


# Set the base directory to the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


# Set up oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";

    # Install plugins
    $DOTFILES_DIR/scripts/install_zsh_plugins.sh
    rm ~/.zshrc
fi

# List of directories to stow (excluding the script itself)
MODULES=(zsh alacritty git emacs bash i3 tmux nvim vim nano btop htop)

# Stow each module
for module in "${MODULES[@]}"; do
    echo "Stowing $module..."
    stow -v -d "$DOTFILES_DIR" -t "$HOME" "$module"
done

echo "Dotfiles have been successfully linked!"

