$DOTFILES_REPO="https://github.com/nnapik/dotfiles"
$DOTFILES_FOLDER="$HOME/.dotfiles"
$SSH_EMAIL="nnapik@gmail.com"

ECHO "Running...
  _           _        _ _       _     
 (_)_ __  ___| |_ __ _| | |  ___| |__  
 | | '_ \/ __| __/ _  | | | / __| '_ \ 
 | | | | \__ \ || (_| | | |_\__ \ | | |
 |_|_| |_|___/\__\__,_|_|_(_)___/_| |_|
 -----
- Sets up a Linux, Windows or macOS based development machine.
- Safe to run repeatedly (checks for existing installs)
- Repository at https://github.com/nnapik/dotfiles
- installing files to $HOME
- Fork as needed
- Deeply inspired by https://github.com/elithrar/dotfiles
 -----
"

ECHO "Checking for dotfiles folder"

IF (Test-Path $DOTFILES_FOLDER) {
    ECHO "Folder found @$DOTFILES_FOLDER"
    ECHO "updating config files"
    pushd $DOTFILES_FOLDER
    git pull
    popd
}
ELSE {
    ECHO "Folder not found @$DOTFILES_FOLDER"
    ECHO "Cloning new version from git repo"
    git clone $DOTFILES_REPO $DOTFILES_FOLDER
}

ECHO "Linking dotfiles"
#for /f %%f in (`dir /b %DOTFILES_FOLDER\files\`) do if %%f

Get-ChildItem "$DOTFILES_FOLDER\files" | 
Foreach-Object {     
    $fname = $_.BaseName
    $link = "$HOME\.$fname"
    ECHO "Linking $_>$link"
    if (Test-Path $link) { Remove-Item $link }
    cmd /c mklink $link $_.FullName
}

