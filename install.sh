#!/bin/bash
# sets up a linux and/or WSL based dev-env
# inspired by elithrar/dotfiles
DOTFILES_REPO="https://github.com/nnapik/dotfiles"
DOTFILES_FOLDER="$HOME/.dotfiles"
APT_PACKAGES="git htop vim python youtube-dl zsh"
SSH_EMAIL="nnapik@gmail.com"

# Colors 
reset="$(tput sgr0)" 
highlight="$(tput smso)" 
dim="$(tput dim)" 
red="$(tput setaf 1)" 
blue="$(tput setaf 4)" 
green="$(tput setaf 2)" 
yellow="$(tput setaf 3)" 
bold=$(tput bold) 
normal=$(tput sgr0) 
underline="$(tput smul)" 
indent="   "

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

# ---------
# Setup
# ---------
printf "
${yellow}
Running...
 _           _        _ _       _     
(_)_ __  ___| |_ __ _| | |  ___| |__  
| | '_ \/ __| __/ _  | | | / __| '_ \ 
| | | | \__ \ || (_| | | |_\__ \ | | |
|_|_| |_|___/\__\__,_|_|_(_)___/_| |_|

-----
- Sets up a Linux or macOS based development machine.
- Safe to run repeatedly (checks for existing installs)
- Repository at https://github.com/nnapik/dotfiles
- installing files to $HOME
- Fork as needed
- Deeply inspired by https://github.com/elithrar/dotfiles
-----
${reset}
"
#Check environments# Check environments
OS=$(uname -s 2> /dev/null)
if [ "${OS}" = "Linux" ]; then
    IS_WSL=false
    # Check Debian vs. RHEL
    if [ -f /etc/os-release ] && $(grep -iq "Debian" /etc/os-release); then
        DISTRO="Debian"
    fi

    if $(grep -q "Microsoft" /proc/version); then
        IS_WSL=true
    fi
fi
print_info "Detected environment: ${OS} - ${DISTRO} (WSL: ${IS_WSL})"

# Check for connectivity
if [ ping -q -w1 -c1 google.com &>/dev/null ]; then
    print_error "Cannot connect to the Internet"
    exit 0
else
    print_success "Internet reachable"
fi

# Ask for sudo
sudo -v &> /dev/null

# Update the system & install core dependencies
if [ "$OS" = "Linux" ] && [ "$DISTRO" = "Debian" ]; then
    print_info "Updating system packages"
    sudo apt-get update
    sudo apt-get -y upgrade
    sudo apt-get -y install build-essential curl file git
else
    print_info "Skipping system package updates"
fi

if ! [ -d "${DOTFILES_FOLDER}" ]; then
    print_info "Cloning dotfiles"
    git clone ${DOTFILES_REPO} ${DOTFILES_FOLDER}
fi

print_info "Linking dotfiles"
for f in ${DOTFILES_FOLDER}/files/*; do
    print_info "linking: $f"
    ln -fs $f ~/.$(basename -- $f)
done
#rcup -d "${DOTFILES_FOLDER}/files"
print_success "dotfiles installed"

print_success "All done! Visit https://github.com/nnapik/dotfiles for the full source & related configs."
