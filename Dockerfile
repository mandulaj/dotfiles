FROM ubuntu:24.04

ARG USERNAME
ARG PASSWORD
ARG USER_ID
ARG GROUP_ID


ENV TERM xterm-256color

# Bootstrapping packages needed for installation
RUN \
  apt-get update && \
  apt-get install -yqq \
    locales \
    lsb-release \
    software-properties-common && \
  apt-get clean

# Set locale to UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
RUN localedef -i en_US -f UTF-8 en_US.UTF-8 && \
  /usr/sbin/update-locale LANG=$LANG

# Install dependencies
RUN DEBIAN_FRONTEND=noninteractive \
  apt -y update && \
  apt -y install \
    autoconf \
    build-essential \
    curl \
    fontconfig \
    git \
    python3 \
    python3-setuptools \
    python3-pip \
    python3-dev \
    sudo \
    stow \
    tmux \
    neovim \
    vim \
    wget \
    zsh && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Remove ubuntu user
RUN deluser --remove-home ubuntu

# Create User
RUN groupadd -g ${GROUP_ID} ${USERNAME} && useradd -u ${USER_ID} -g ${GROUP_ID} -ms /bin/zsh ${USERNAME} && usermod -aG sudo ${USERNAME} && echo "${USERNAME}:${PASSWORD}" | chpasswd

USER ${USERNAME}

WORKDIR /home/${USERNAME}


# Install dotfiles

COPY . /home/${USERNAME}/.dotfiles

RUN cd /home/${USERNAME}/.dotfiles && ./bootstrap.sh

# Run a zsh session
CMD [ "/bin/zsh" ]
