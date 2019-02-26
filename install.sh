#!/bin/bash
# sets up a linux and/or WSL based dev-env
# inspired by elithrar/dotfiles
DOTFILES_REPO="https://github.com/nnapik/dotfiles"
APT_PACKAGES="git htop vim python youtube-dl zsh"
SSH_EMAIL="nnapik@gmail.com"



echo $PATH
ln -sf $PATH/vimrc ~/.vimrc
ln -sf $PATH/bashrc ~/.bashrc
ln -sf $PATH/bash_aliases ~/.bash_aliases
