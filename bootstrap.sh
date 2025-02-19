#!/bin/bash


# Set the base directory to the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# List of directories to stow (excluding the script itself)
MODULES=(zsh git bin bash i3 tmux vim)

# Stow each module
for module in "${MODULES[@]}"; do
    echo "Stowing $module..."
    stow -v -d "$DOTFILES_DIR" -t "$HOME" "$module"
done

echo "Dotfiles have been successfully linked!"

