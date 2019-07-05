#!/bin/sh

function install_oh_my_zsh() {
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

function install_tmux_plugins() {
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

# install rcm
function install_other()  {
  install_oh_my_zsh
  install_tmux_plugins
}

# Need a pacmanFile, simliar to bundler File
function install_linux() {
  sudo pacman -S autojump
  yay -S rcm
}

function install_macos() {
  brew install rcm
  brew bundle
}

env RCRC=./rcrc rcup
