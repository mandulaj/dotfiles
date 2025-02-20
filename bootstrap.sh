#!/bin/bash


# Set the base directory to the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


# Set up oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";

    # Install plugins
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

    rm ~/.zshrc
fi

# List of directories to stow (excluding the script itself)
MODULES=(zsh git emacs bash i3 tmux nvim vim nano)

# Stow each module
for module in "${MODULES[@]}"; do
    echo "Stowing $module..."
    stow -v -d "$DOTFILES_DIR" -t "$HOME" "$module"
done

echo "Dotfiles have been successfully linked!"

