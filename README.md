Jakub's Dotfiles
================

My Personal dotfiles.

* Should have minimal prerequisite to get started
* Should be fast to bootstrap and deploy
* Should be modular and flexible for different systems

![terminal](.assets/terminal.png)

## Get started
To install the dotfiles on a new system, run the following:

### Prerequisits
You must have `git` and `stow` installed for the rest to work

### Installation
```bash
git clone git@github.com:mandulaj/dotfiles.git .dotfiles && cd .dotfiles
./bootstrap.sh
```

## Modules

### [git](./git)
### [i3](./i3)
### [nvim](./nvim)
### [tmux](./tmux)
### [vim](./vim)
### [nvim](./nvim)
### [zsh](./zsh)

## Docker test environment
```bash
docker compose build

docker compose run -it dotfiles
```


