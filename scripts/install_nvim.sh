#!/bin/bash

ARCH=$(uname -m)
if [ "$ARCH" = "aarch64" ]; then
    ARCH="arm64"
fi

NVIM_FILE="nvim-linux-$ARCH.tar.gz"

sudo rm -rf /opt/nvim
sudo mkdir /opt/nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/${NVIM_FILE}
sudo tar -C /opt/nvim -xzf $NVIM_FILE  --strip-components=1
rm $NVIM_FILE
