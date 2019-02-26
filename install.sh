#!/bin/bash
# sets up a linux and/or WSL based dev-env
# inspired by elithrar/dotfiles
DOTFILES_REPO="https://github.com/nnapik/dotfiles"
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

echo $PATH
ln -sf $PATH/vimrc ~/.vimrc
ln -sf $PATH/bashrc ~/.bashrc
ln -sf $PATH/bash_aliases ~/.bash_aliases
