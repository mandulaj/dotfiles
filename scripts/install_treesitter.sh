#!/bin/bash


curl -L -o tree-sitter.gz "https://github.com/tree-sitter/tree-sitter/releases/download/v0.25.3/tree-sitter-linux-x64.gz" && \
gunzip tree-sitter.gz && \
chmod +x tree-sitter && \
mkdir -p ~/.local/bin
mv tree-sitter ~/.local/bin/

