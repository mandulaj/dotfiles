# MIT License
#
# Copyright (c) 2025 Jakub Mandula

# Export the root of the .dotfiles
export DOTFILES_DIR="$(dirname "$(dirname "$(readlink -f "${(%):-%N}")")")"

#if [ ! "$TMUX" ]; then

#        tmux attach -t main || tmux new -s main
#fi


# Import exports, aliases and extras
for file in ~/.{exports,aliases,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

# Add more locations to path
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.config/emacs/bin:$PATH
export PATH=$DOTFILES_DIR/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export AGNOSTER_DIR_BG=cyan

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

DISABLE_AUTO_UPDATE="true"
# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"
#ZSH_TMUX_AUTOSTART=true
# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git git-extras colored-man-pages ssh catimg thefuck z zsh-autosuggestions zsh-syntax-highlighting vi-mode
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
   export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
#
export LD_LIBRARY_PATH=LD_LIBRARY_PATH:/usr/local/lib
export PATH=$PATH:$HOME/git/openeb/build/bin
export PATH=$PATH:/opt/stm32cubeclt/STLink-gdb-server/bin

[ -f $HOME/git/openeb/build/utils/scripts/setup_env.sh ] && source $HOME/git/openeb/build/utils/scripts/setup_env.sh

alias metavision_studio='xhost "+local:*"; docker run -it  --privileged  -v /dev/bus/usb:/dev/bus/usb -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix/ -v $(pwd):/home/$USER/metavision -v /home/$USER/.config/Metavision\ Studio:/home/$USER/.config/Metavision\ Studio -e GDK_SCALE=0.5 --rm --net=host --shm-size 100000000000 metavisionsdk22_${USER} /bin/bash -c "metavision_studio; while /usr/bin/pgrep metavision >/dev/null; do sleep 1; done"'

#Ros Docker

alias rviz='docker run -it --rm --privileged --net=host -e DISPLAY=$DISPLAY -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" -v "$(pwd):/data" --ulimit nofile=1024:524288 -w /data osrf/ros:noetic-desktop rviz'
alias rosbash='docker run -it --rm --privileged  --net=host -e DISPLAY=$DISPLAY -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" -v "$(pwd):/data" --ulimit nofile=1024:524288 -w /data osrf/ros:noetic-desktop bash'
alias roscore='docker run -it --rm --net=host --ulimit nofile=1024:524288 osrf/ros:noetic-desktop roscore'

alias rviz2='docker run -it --rm --privileged --ipc=host --net=host -e DISPLAY=$DISPLAY -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" -v /dev/shm:/dev/shm -v "$(pwd):/data" --ulimit nofile=1024:524288 -w /data osrf/ros:humble-desktop rviz2'
alias rosbash2='docker run -it --rm --privileged --ipc=host --net=host -e DISPLAY=$DISPLAY -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" -v /dev/shm:/dev/shm -v "$(pwd):/data" --ulimit nofile=1024:524288 -w /data osrf/ros:humble-desktop-full bash'


alias pac=yay
alias sub=subl3
alias sc='systemctl'
alias ssc='sudo systemctl'
alias sudo='sudo '
alias diff=colordiff
alias mytools='pygmentize -O style=native $HOME/Documents/Personal/Cheatsheets/commands/1_my_tools.md'
alias mt=mytools
cheat() {
    local ARG="${1:-README}"
    if [[ "$ARG" == "cd" ]]; then
        cd $HOME/Documents/Personal/Cheatsheets/commands
    else
        pygmentize -O style=native "$HOME/Documents/Personal/Cheatsheets/commands/$ARG.md"
    fi
}

alias bkup='$HOME/Documents/scripts/backup/backup.sh'

cdd() {
    cd /run/media/$USER/$1
}

#alias ise=sh -c "unset LANG && unset QT_PLUGIN_PATH && source /opt/Xilinx/14.7/ISE_DS/settings64.sh && ise"
#alias sha='/home/jakub/Documents/scripts/sha.sh'
#alias backup='/home/jakub/Documents/scripts/backup.sh'
#alias ubackup='/home/jakub/Documents/scripts/ubackup.sh'
#alias zbarcam='LD_PRELOAD=/usr/lib/libv4l/v4l1compat.so zbarcam'

# Python
alias ipy='ipython --no-banner'
alias ipyn='ipython notebook'

# File listing
alias ls='ls -v --color=tty'
alias ll='ls -1lF --si'
alias la='ls -1lAF --si'
alias lr='ls -tRF --si'
alias lt='ls -1ltF --si'
alias l='ll'

#alias matlab='/usr/local/MATLAB/R2017a/bin/matlab'

# VPN helpers
alias svpn='sudo surfshark-vpn'
alias ssvpn='yes | sudo surfshark-vpn attack'
# open(){
#   nautilus $@ >/dev/null 2>&1 &
# }
#
alias open='nautilus . &'

# Swap File helpers
alias swon='sudo swapon -a'
alias swoff='sudo swapoff -a'


#BTRFS
#
alias cp='cp --reflink=auto '

alias bdu='btrfs fi du --si -s'
alias bdf='btrfs fi usage --si -T'
alias bss='sudo btrfs sub show'
alias bls='sudo btrfs sub list'
alias bcs='sudo compsize -x'

alias snaphome='snapper -c home'
alias snapls='snapper -c home list --columns number,type,pre-number,date'

alias dus='du -sch $(ls -A) | sort -h'


snapcd() {
    if [[ $1 == -h || $1 == --help ]]; then
        echo 'snapcd - cd to a snapshot'
        echo '    snapcd -h/--help       - Print this help'
        echo '    snapcd [-r[n]] [snap]  - Jump to current location to `n`-th last snapshot, or snapshot `snap` - Default jump to last snapshot'
        echo '                           - if executed in snapshot without parameters, jumps back to main FS'
        echo ''
        echo '    snapcd -a[n] [snap]    - Jump to base directory of `n`-th last snapshot or snapshot `snap`'

        return;
    fi
    SNAP_DIR="/home/.snapshots"
    PWD=`pwd -P`

    ## Absolute change to latest snapshot ( -a[n] )
    if [[ $1 == -a* ]]; then

        # Get any characters after -a
        OFFSET=$(echo $1 | cut -c 3-)
        if ! [[ "$OFFSET" =~ '^[1-9]+[0-9]*$' ]]; then
            # Set the offset to 1 if the characters aren't numeric...
            OFFSET=1
        fi

        REL_PATH=""
        BASE=$SNAP_DIR
        # Use 2nd param as snapshot number, else use the offset
        ID=${2:-$(ls -1 /home/.snapshots | tail -n$OFFSET | head -1)}

        echo "Absolute jump to snapshot $ID"

    # Change back to original
    elif [[ "$PWD" =~ ^/home/.snapshots/[0-9]+/snapshot/jakub* ]]; then
        # We were in a snapshot, jump back to current snapshot
        ID=0

        REL_PATH=`pwd -P | cut -d/ -f7-`
        BASE="/home/jakub"

    else
    # Change to snapshot in relative way

        # Make sure we are in /home
        if [[ "$PWD" =~ ^/home/jakub.* ]]; then
            REL_PATH=`pwd -P | cut -d/ -f4-`
        else
            echo "You are not at HOME :)"
            REL_PATH=""
            return;
        fi

        # Jump to -r[nth] last snapshot
        if [[ $1 == -r* ]]; then
            OFFSET=$(echo $1 | cut -c 3-)
            if ! [[ "$OFFSET" =~ '^[1-9]+[0-9]*$' ]]; then
                OFFSET=1
            fi
            ID=$(ls -1 /home/.snapshots | tail -n$OFFSET | head -1)
        else
            OFFSET=1

            ID=${1:-$(ls -1 /home/.snapshots | tail -n1)}
        fi

        BASE=$SNAP_DIR

        echo "Relative jump to snapshot $ID"
    fi


    # Change back case
    if [[ "$ID" -eq "0" ]]; then
        DESTINATION="$BASE/$REL_PATH"

    else

        if [[ ! -d "$SNAP_DIR/$ID" ]]; then
            echo "Snapshot $ID does not exist"
            return
        fi
        DESTINATION="$BASE/$ID/snapshot/jakub/$REL_PATH"
    fi

    if [[ -d "$DESTINATION" ]]; then
        cd $DESTINATION;
    else
        echo "Directory $REL_PATH does not exist"
    fi
}

# RSYNC
alias rs='rsync -ahPX --stats --info=progress2'

# Proxy Firefox
#
#
socksfox() {
    local socket="${1:-openwrt-public2}"
    echo "$socket"
    ssh -N -D 1337 $socket &;
    firefox -P socks_proxy;
    fg
}


export QT_QPA_PLATFORM='xcb'
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

#if [ "$TMUX" = "" -a $TERM != "screen" ]; then tmux; fi
alias dotfiles='git --git-dir=$HOME/.dotfiles_old/ --work-tree=$HOME'

alias em="emacsclient -nw -c -a 'emacs' --frame-parameters='((fullscreen . maximized))'"

#alias chatgpt='chatgpt --model gpt-4o-mini-2024-07-18'
alias gpt='$HOME/.conda/envs/gpt-cli/bin/gpt'

alias vim='nvim'
alias v='nvim'
alias work.sh="$HOME/.screenlayout/Work.sh"

export USER_ID=`id -u`
export USERNAME=`whoami`
export GROUP_ID=`id -g`

alias pietro='feh --bg-scale /home/jakub/Downloads/image_2024_11_11T11_22_25_371Z.png && sleep 1 && feh --bg-scale /home/jakub/Pictures/Wallpapers/3sUrMn0.jpg'


# Load Secret Keys and Variables
[ -f $DOTFILES_DIR/secret-keys.sh ] && source $DOTFILES_DIR/secret-keys.sh
