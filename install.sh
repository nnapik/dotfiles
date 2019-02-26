#!/bin/bash
# sets up a linux and/or WSL based dev-env
# inspired by elithrar/dotfiles
DOTFILES_REPO="https://github.com/nnapik/dotfiles"
DOTFILES_FOLDER="~/.dotfiles"
APT_PACKAGES="git htop vim python youtube-dl zsh"
SSH_EMAIL="nnapik@gmail.com"

trap 'ret=$?; test $ret -ne 0 && printf "${red}Setup failed${reset}\n" >&2; exit $ret' EXIT
set -e

# --- Helpers
print_success() {
    printf "${green}✔ success:${reset} %b\n" "$1"
}

print_error() {
    printf "${red}✖ error:${reset} %b\n" "$1"
}

print_info() {
    printf "${blue}🛈 info:${reset} %b\n" "$1"
}

PWD=$(pwd)
echo $PWD
ln -sf $PWD/vimrc ~/.vimrc
ln -sf $PWD/bashrc ~/.bashrc
ln -sf $PWD/bash_aliases ~/.bash_aliases
